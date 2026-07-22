#!/usr/bin/env ruby

require "json"
require "pathname"
require "yaml"

ROOT = Pathname.new(__dir__).parent.expand_path
errors = []

required = %w[
  README.md
  README.zh-CN.md
  LICENSE
  CHANGELOG.md
  CONTRIBUTING.md
  SECURITY.md
  .codex-plugin/plugin.json
  .agents/plugins/marketplace.json
  agents/openai.yaml
  evals/cases.yaml
  examples/README.md
  examples/README.zh-CN.md
  examples/project-context-template.md
  examples/project-context-template.zh-CN.md
  examples/sop-agent-handoff.md
  skills/community-ops-router/references/operating-principles.zh-CN.md
  skills/community-ops-router/references/sop-contract.md
  skills/community-ops-automation-workflow/references/platform-agent-patterns.md
]

required.each do |relative|
  errors << "Missing required file: #{relative}" unless (ROOT + relative).file?
end

begin
  plugin = JSON.parse((ROOT + ".codex-plugin/plugin.json").read)
  allowed_plugin_fields = %w[author description homepage id interface keywords license mcpServers name repository skills version]
  unknown_plugin_fields = plugin.keys - allowed_plugin_fields
  errors << "Unsupported plugin fields: #{unknown_plugin_fields.join(', ')}" unless unknown_plugin_fields.empty?
  errors << "Plugin name must be community-ops-kit" unless plugin["name"] == "community-ops-kit"
  errors << "Plugin version must use semantic versioning" unless plugin["version"].to_s.match?(/\A(?:0|[1-9]\d*)\.(?:0|[1-9]\d*)\.(?:0|[1-9]\d*)(?:-[0-9A-Za-z.-]+)?(?:\+[0-9A-Za-z.-]+)?\z/)
  changelog_version = (ROOT + "CHANGELOG.md").read[/^## ([0-9]+\.[0-9]+\.[0-9]+) - /, 1]
  errors << "Plugin version must match the latest changelog version" unless plugin["version"] == changelog_version
  errors << "Plugin description is missing" if plugin["description"].to_s.strip.empty?
  errors << "Plugin author name is missing" if plugin.dig("author", "name").to_s.strip.empty?
  errors << "Plugin skills path must be ./skills/" unless plugin["skills"] == "./skills/"
  %w[displayName shortDescription longDescription developerName category defaultPrompt].each do |field|
    errors << "Plugin interface is missing #{field}" if plugin.dig("interface", field).nil?
  end
  capabilities = plugin.dig("interface", "capabilities")
  errors << "Plugin capabilities must be a non-empty string array" unless capabilities.is_a?(Array) && capabilities.all? { |item| item.is_a?(String) && !item.empty? }
rescue StandardError => e
  errors << "Invalid plugin manifest: #{e.message}"
end

begin
  marketplace = JSON.parse((ROOT + ".agents/plugins/marketplace.json").read)
  entry = marketplace.fetch("plugins").find { |item| item["name"] == "community-ops-kit" }
  errors << "Marketplace entry is missing" unless entry
  errors << "Marketplace source must point to ./" if entry && entry.dig("source", "path") != "./"
  errors << "Marketplace installation policy must be AVAILABLE" if entry && entry.dig("policy", "installation") != "AVAILABLE"
  errors << "Marketplace authentication policy must be ON_INSTALL" if entry && entry.dig("policy", "authentication") != "ON_INSTALL"
rescue StandardError => e
  errors << "Invalid marketplace manifest: #{e.message}"
end

skill_files = Dir.glob((ROOT + "skills/*/SKILL.md").to_s).sort
errors << "Expected 10 skills, found #{skill_files.length}" unless skill_files.length == 10

skill_files.each do |file_name|
  file = Pathname.new(file_name)
  text = file.read
  match = text.match(/\A---\s*\n(.*?)\n---\s*\n/m)

  unless match
    errors << "Missing YAML frontmatter: #{file.relative_path_from(ROOT)}"
    next
  end

  begin
    metadata = YAML.safe_load(match[1])
    expected_name = file.parent.basename.to_s
    errors << "Skill name does not match folder: #{expected_name}" unless metadata["name"] == expected_name
    errors << "Skill description is missing: #{expected_name}" if metadata["description"].to_s.strip.empty?
  rescue StandardError => e
    errors << "Invalid skill frontmatter in #{file.relative_path_from(ROOT)}: #{e.message}"
  end

  errors << "SKILL.md exceeds 500 lines: #{file.relative_path_from(ROOT)}" if text.lines.length > 500
  errors << "Unbalanced code fences: #{file.relative_path_from(ROOT)}" if text.scan(/^```/).length.odd?
  errors << "Missing Project Inputs section: #{file.relative_path_from(ROOT)}" unless text.include?("## Project Inputs")

  ui_file = file.parent + "agents/openai.yaml"
  unless ui_file.file?
    errors << "Missing agents/openai.yaml: #{file.parent.basename}"
    next
  end

  begin
    ui = YAML.safe_load(ui_file.read)
    prompt = ui.dig("interface", "default_prompt").to_s
    errors << "Default prompt must name $#{file.parent.basename}: #{ui_file.relative_path_from(ROOT)}" unless prompt.include?("$#{file.parent.basename}")
  rescue StandardError => e
    errors << "Invalid UI metadata in #{ui_file.relative_path_from(ROOT)}: #{e.message}"
  end
end

markdown_files = Dir.glob((ROOT + "**/*.md").to_s)
markdown_files.each do |file_name|
  file = Pathname.new(file_name)
  text = file.read
  errors << "Unbalanced code fences: #{file.relative_path_from(ROOT)}" if text.scan(/^```/).length.odd?

  text.scan(/\[[^\]]+\]\(([^)]+)\)/).flatten.each do |target|
    next if target.match?(%r{\Ahttps?://}) || target.start_with?("#")

    local_path = target.split("#", 2).first
    resolved = (file.parent + local_path).expand_path
    errors << "Broken link in #{file.relative_path_from(ROOT)}: #{target}" unless resolved.exist?
  end
end

english_markdown_files = markdown_files.reject { |file_name| file_name.end_with?(".zh-CN.md") }
english_markdown_files.each do |file_name|
  file = Pathname.new(file_name)
  errors << "Found Chinese text in English Markdown: #{file.relative_path_from(ROOT)}" if file.read.match?(/\p{Han}/)
end

english_examples = Dir.glob((ROOT + "examples/*.md").to_s).reject { |file_name| file_name.end_with?(".zh-CN.md") }
chinese_examples = Dir.glob((ROOT + "examples/*.zh-CN.md").to_s)
protected_example_literals = %w[
  observed prepared approved executed verified recorded reviewed blocked ambiguous cancelled
] + ["data gap", "pending approval"]

english_examples.each do |file_name|
  file = Pathname.new(file_name)
  counterpart = Pathname.new(file_name.sub(/\.md\z/, ".zh-CN.md"))
  errors << "Missing Chinese example: #{counterpart.relative_path_from(ROOT)}" unless counterpart.file?
  next unless counterpart.file?

  english_text = file.read
  chinese_text = counterpart.read
  english_links = english_text.scan(/\[[^\]]+\]\(([^)]+)\)/).flatten.map { |target| target.split("#", 2).first }
  errors << "English example does not link to Chinese version: #{file.relative_path_from(ROOT)}" unless english_links.include?(counterpart.basename.to_s)

  english_lines = english_text.lines.count { |line| !line.strip.empty? }
  chinese_lines = chinese_text.lines.count { |line| !line.strip.empty? }
  line_ratio = [english_lines, chinese_lines].min.fdiv([english_lines, chinese_lines].max)
  errors << "Example translation appears incomplete: #{counterpart.relative_path_from(ROOT)}" if line_ratio < 0.7

  english_headings = english_text.scan(/^(#+) /).flatten.map(&:length)
  chinese_headings = chinese_text.scan(/^(#+) /).flatten.map(&:length)
  errors << "Example heading structure differs: #{file.relative_path_from(ROOT)}" unless english_headings == chinese_headings
  errors << "Example code-block structure differs: #{file.relative_path_from(ROOT)}" unless english_text.scan(/^```/).length == chinese_text.scan(/^```/).length

  english_numbers = english_text.scan(/\b\d+(?:\.\d+)?\b/).uniq.sort
  chinese_numbers = chinese_text.scan(/\b\d+(?:\.\d+)?\b/).uniq.sort
  errors << "Example numeric facts differ: #{file.relative_path_from(ROOT)}" unless english_numbers == chinese_numbers

  english_code_literals = english_text.scan(/`([^`]+)`/).flatten
  protected_in_source = english_code_literals.select do |literal|
    literal.start_with?("community-ops-") || protected_example_literals.include?(literal)
  end
  missing_literals = protected_in_source.uniq.reject { |literal| chinese_text.include?("`#{literal}`") }
  errors << "Chinese example is missing protected literals #{missing_literals.join(', ')}: #{counterpart.relative_path_from(ROOT)}" unless missing_literals.empty?
end

chinese_examples.each do |file_name|
  file = Pathname.new(file_name)
  counterpart = Pathname.new(file_name.sub(/\.zh-CN\.md\z/, ".md"))
  errors << "Missing English example: #{counterpart.relative_path_from(ROOT)}" unless counterpart.file?
  next unless counterpart.file?

  chinese_links = file.read.scan(/\[[^\]]+\]\(([^)]+)\)/).flatten.map { |target| target.split("#", 2).first }
  errors << "Chinese example does not link to English version: #{file.relative_path_from(ROOT)}" unless chinese_links.include?(counterpart.basename.to_s)
end

readme_texts = [ROOT + "README.md", ROOT + "README.zh-CN.md"].map(&:read)
readme_heading_levels = readme_texts.map { |text| text.scan(/^([#]{2,3}) /).flatten.map(&:length) }
errors << "README English and Chinese section structures differ" unless readme_heading_levels[0] == readme_heading_levels[1]

readme_content_lines = readme_texts.map { |text| text.lines.count { |line| !line.strip.empty? } }
readme_line_ratio = readme_content_lines.min.fdiv(readme_content_lines.max)
errors << "README translation appears incomplete" if readme_line_ratio < 0.7
errors << "README English and Chinese code-block structures differ" unless readme_texts[0].scan(/^```/).length == readme_texts[1].scan(/^```/).length

begin
  evals = YAML.safe_load((ROOT + "evals/cases.yaml").read)
  cases = evals.fetch("cases")
  errors << "At least six eval cases are required" if cases.length < 6
  cases.each do |item|
    %w[id expected_skill prompt assertions].each do |field|
      errors << "Eval case is missing #{field}: #{item.inspect}" unless item.key?(field)
    end
  end
rescue StandardError => e
  errors << "Invalid eval cases: #{e.message}"
end

public_files = Dir.glob((ROOT + "**/*").to_s).select do |path|
  File.file?(path) && File.expand_path(path) != File.expand_path(__FILE__)
end
all_text = public_files.map { |path| File.binread(path) }.join("\n")

forbidden = {
  "unreplaced GitHub owner" => /__GITHUB_OWNER__/,
  "private project name" => /\b(?:Viyou|Vireel|WANN|MEE6)\b/i,
  "private strategist language" => /the user's personal community-operations capability/i,
  "GitHub token" => /\bgh[oprsu]_[A-Za-z0-9_]{20,}\b/,
  "OpenAI-style secret" => /\bsk-[A-Za-z0-9_-]{20,}\b/,
  "Discord webhook URL" => %r{https://discord(?:app)?\.com/api/webhooks/}i
}

forbidden.each do |label, pattern|
  errors << "Found #{label}" if all_text.match?(pattern)
end

if errors.empty?
  puts "Validation passed: #{skill_files.length} skills, #{markdown_files.length} Markdown files."
  exit 0
end

warn errors.map { |error| "- #{error}" }.join("\n")
exit 1
