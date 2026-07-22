# Community Ops Kit

[简体中文](README.zh-CN.md)

Community Ops Kit turns messy community notes into evidence-based, verifiable operating workflows for AI agents and human operators. It finds the main friction, routes work to specialist skills, produces reusable SOPs, keeps sensitive execution owner-reviewed, and feeds verified results into daily and weekly decisions.

It works with Codex and other tools that support the open Agent Skills format.

Built for community operators, community managers, creator or customer communities, and teams adding AI without giving it unchecked permissions.

## What The Skills Include

The kit includes reusable community-operations judgment, workflows, output structures, and safety boundaries. It does not include the author's community rules, channels, roles, rewards, member benefits, user data, or bot configuration.

Provide only the project details relevant to the current task. For an activity, that may include the target segment, participation action, timing, submission method, and reward status. For a weekly review, provide the week's records, data sources, and metric definitions. Unknown fields may stay blank; the skills should mark them as data gaps or owner decisions instead of borrowing values from repository examples.

Use the [community project context template](examples/project-context-template.md) as a fill-in checklist. Never add passwords, tokens, webhook URLs, full private messages, or unnecessary personal data.

## Two Ways To Use The Kit

### Focused mode

Call one specialist when the task is clear. Use `community-ops-activity` for an activity or `community-ops-daily-report` for a daily report. The full workflow is not required first.

```text
Use community-ops-activity to design an activity from the project details below. List missing items for confirmation and do not use example values.

[Paste only the details relevant to this activity]
```

### Full-workflow mode

Give the records to `community-ops-router` when the problem spans several areas or the right specialist is unclear. The router should call only the skills needed for the task.

## What You Get In One Run

```text
messy notes and records
-> confirmed facts, assumptions, data gaps, and approvals
-> one main operating friction and prioritized action
-> specialist output and reusable SOP
-> operator / AI / automation / platform handoff
-> approval, execution, read-back verification, and writeback
-> daily or weekly decision
```

The kit keeps `prepared`, `approved`, `executed`, and `verified` separate, so an automation run is never mistaken for a completed community action.

## Start Without Choosing A Skill

Give your existing notes to the router. You do not need to clean the input or remember all ten skill names:

```text
Use community-ops-router to read the community records below. Separate confirmed facts, assumptions, data gaps, and approval items. Find the main operating friction, call only the specialist skills that are needed, and turn the next action into an SOP with ownership, execution roles, approval scope, verification, and a review rule.

[Paste chat summaries, activity records, member feedback, metrics, or work notes]
```

See the complete path from messy notes to operating decisions in the [end-to-end example](examples/end-to-end-operating-loop.md).

## How The Kit Makes Decisions

1. **Start with evidence**: separate facts, assumptions, data gaps, and approval items.
2. **Find the main friction**: locate the lifecycle step blocking the next user action.
3. **Choose the smallest useful change**: prefer an action that can run and produce evidence this week.
4. **Give each surface one clear job**: entry points guide, activity surfaces collect participation, and reports support decisions.
5. **Automate within a boundary**: collection, organization, reminder preparation, and checks may run automatically; sending reminders and other external actions stay human-confirmed.
6. **Verify external results**: distinguish preparation, approval, execution attempts, verified outcomes, and blocked or ambiguous states.
7. **Make every action reviewable**: write material results back to the operating record and define the next decision.

See [Operating Principles](skills/community-ops-router/references/operating-principles.md) for the full decision questions, anti-patterns, and output check.

## What It Covers

| Skill | Use it for |
|---|---|
| `community-ops-router` | Diagnose, route, and operationalize work as reusable SOPs |
| `community-ops-onboarding` | Newcomer paths, first actions, activation, and routing |
| `community-ops-activity` | Campaigns, challenges, submissions, voting, rewards, and results |
| `community-ops-creator-assets` | Creators, UGC, showcases, attribution, and reusable content |
| `community-ops-paid-members` | Paid, premium, VIP, and high-value member operations |
| `community-ops-daily-report` | Daily operating logs and owner updates |
| `community-ops-weekly-review` | Weekly evidence, decisions, gaps, and priorities |
| `community-ops-automation-workflow` | Safe AI/bot/operator handoffs with execution verification |
| `community-ops-support-risk` | Support, moderation, privacy, payment, access, and permission risk |
| `community-ops-expression` | Natural announcements, reports, articles, and stakeholder writing |

## Operating Loop

```text
community signal
-> operator judgment
-> specialist skill
-> reusable SOP and exact handoff
-> draft or safe automation
-> human approval where required
-> bounded execution
-> read-back verification and state writeback
-> daily record
-> weekly review
-> workflow update
```

## Install

### Cross-Agent Installer

```bash
npx skills add ShiroRyu9/community-ops-kit
```

List the available skills before installing:

```bash
npx skills add ShiroRyu9/community-ops-kit --list
```

### Codex Plugin

Add this repository as a plugin marketplace:

```bash
codex plugin marketplace add ShiroRyu9/community-ops-kit
```

Then open Codex, run `/plugins`, select **Community Ops Kit**, install it, and start a new session.

### Manual Install

Copy the folders under `skills/` into the skills directory used by your agent. For Codex, the global directory is `~/.codex/skills/` and the project directory is `.agents/skills/`.

## Quick Start

Start with the router when the problem spans several areas:

```text
Use community-ops-router to diagnose why new members join but do not take a first action. Give me the smallest useful changes, evidence to collect, and approval boundaries.
```

Call a specialist skill for a focused task:

```text
Use community-ops-activity to design an activity from the details below. Keep blank fields as confirmation items:
Goal: collect product examples for a possible showcase
Audience: active creators
User action: create and submit one example
Start / deadline / timezone:
Entry / submission surface:
Valid submission format:
Review or feedback method:
Reward or showcase status: pending
Reminder timing and surfaces:
Safety or content constraints:
```

```text
Use community-ops-weekly-review to turn these notes and metrics into confirmed actions, signals, risks, decisions, and next-week priorities.
```

Turn a repeated operation into a safe handoff:

```text
Use community-ops-automation-workflow to turn this reminder process into an owner-reviewed workflow. Define operator, AI, scheduler, and platform-adapter roles; track preparation through verification; and stop on ambiguous external results.
```

See [examples](examples/) for worked scenarios. The [end-to-end operating loop](examples/end-to-end-operating-loop.md) shows how the router coordinates several skills. The [SOP and agent handoff](examples/sop-agent-handoff.md) shows how a recurring action moves from evidence to verified completion.

## FAQ

### Must I import all community rules first?

No. Provide only the context needed for the current task. A publication-ready activity normally needs timing, eligibility, submission, reward, and safety rules. An early activity brainstorm can leave those fields open and receive a list of decisions to confirm.

### Does every run load all ten skills?

Tools that implement progressive Agent Skills loading typically match on skill metadata first, load the selected skill body after it triggers, and read detailed references only when needed. A focused task can call one specialist; complex work may use the router and several specialists. Other AI tools may load skills differently, so actual token use depends on the tool.

### Can I use only one skill?

Yes. After installing the kit, call a specialist by name, or manually copy only the skill folder you need. The router is an entry point for cross-functional work, not a required step for every task.

### Will example activity rules become my defaults?

No. Examples demonstrate input and output shapes only. The operator must provide or confirm community names, platforms, channels, roles, timing, rewards, benefits, policies, and execution tools.

### Will a skill publish, message members, or issue rewards automatically?

Not by default. The kit can organize evidence, prepare drafts, and create checklists. Public posts, DMs, mentions, rewards, discounts, benefit promises, winner lists, permission changes, and bot or webhook changes require explicit human confirmation.

## Safety Model

The skills may organize evidence, draft content, compare options, calculate metrics, and prepare checklists when the environment allows it. They require explicit human confirmation before public posts, DMs, mentions, rewards, discounts, benefit promises, winner lists, permission changes, bot or webhook changes, deletions, or official claims.

No skill should invent missing metrics, policies, approvals, revenue, retention, or growth results.

## Repository Structure

```text
skills/                 Agent Skills and references
examples/               Beginner-friendly worked scenarios
evals/                  Clean-context routing and quality cases
scripts/validate.rb     Local structural and privacy validation
.codex-plugin/          Codex plugin manifest
.agents/plugins/        Codex marketplace metadata
```

## Validate

```bash
ruby scripts/validate.rb
```

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md). Contributions should add a distinct trigger, operator judgment, output, or evidence rule. Platform-specific configuration belongs in examples or adapters rather than the reusable core.

## License

Apache License 2.0. See [LICENSE](LICENSE).
