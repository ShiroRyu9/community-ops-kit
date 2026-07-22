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
  examples/sop-agent-handoff.md
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
