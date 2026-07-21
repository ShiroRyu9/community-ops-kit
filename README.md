# Community Ops Kit

[简体中文](README.zh-CN.md)

Community Ops Kit is an open set of Agent Skills for running evidence-based community operations. It turns broad goals such as "improve engagement" into user segments, concrete actions, operating surfaces, evidence, feedback loops, review decisions, and approval boundaries.

It works with Codex and other tools that support the open Agent Skills format.

## Start Without Choosing A Skill

Give your existing notes to the router. You do not need to clean the input or remember all ten skill names:

```text
Use community-ops-router to read the community records below. Separate confirmed facts, assumptions, data gaps, and approval items. Find the main operating friction, call the specialist skills that are needed, and give me the smallest action we can run this week with a review rule.

[Paste chat summaries, activity records, member feedback, metrics, or work notes]
```

See the complete path from messy notes to operating decisions in the [end-to-end example](examples/end-to-end-operating-loop.md).

## How The Kit Makes Decisions

1. **Start with evidence**: separate facts, assumptions, data gaps, and approval items.
2. **Find the main friction**: locate the lifecycle step blocking the next user action.
3. **Choose the smallest useful change**: prefer an action that can run and produce evidence this week.
4. **Give each surface one clear job**: entry points guide, activity surfaces collect participation, and reports support decisions.
5. **Automate within a boundary**: collection, organization, reminder preparation, and checks may run automatically; sending reminders and other external actions stay human-confirmed.
6. **Make every action reviewable**: define the evidence, review time, owner, and next decision before execution.

See [Operating Principles](skills/community-ops-router/references/operating-principles.md) for the full decision questions, anti-patterns, and output check.

## What It Covers

| Skill | Use it for |
|---|---|
| `community-ops-router` | Diagnose cross-functional problems and route the work |
| `community-ops-onboarding` | Newcomer paths, first actions, activation, and routing |
| `community-ops-activity` | Campaigns, challenges, submissions, voting, rewards, and results |
| `community-ops-creator-assets` | Creators, UGC, showcases, attribution, and reusable content |
| `community-ops-paid-members` | Paid, premium, VIP, and high-value member operations |
| `community-ops-daily-report` | Daily operating logs and owner updates |
| `community-ops-weekly-review` | Weekly evidence, decisions, gaps, and priorities |
| `community-ops-automation-workflow` | Safe recurring workflows with human approval gates |
| `community-ops-support-risk` | Support, moderation, privacy, payment, access, and permission risk |
| `community-ops-expression` | Natural announcements, reports, articles, and stakeholder writing |

## Operating Loop

```text
community signal
-> operator judgment
-> specialist skill
-> draft or safe automation
-> human approval where required
-> daily record
-> weekly review
-> workflow update
```

## Install

### Cross-Agent Installer

```bash
npx skills add lyh974976711-del/community-ops-kit
```

List the available skills before installing:

```bash
npx skills add lyh974976711-del/community-ops-kit --list
```

### Codex Plugin

Add this repository as a plugin marketplace:

```bash
codex plugin marketplace add lyh974976711-del/community-ops-kit
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
Use community-ops-activity to design a seven-day creator challenge with a clear submission format, reminder rhythm, showcase plan, and review metrics.
```

```text
Use community-ops-weekly-review to turn these notes and metrics into confirmed actions, signals, risks, decisions, and next-week priorities.
```

See [examples](examples/) for worked scenarios. The [end-to-end operating loop](examples/end-to-end-operating-loop.md) shows how the router coordinates several skills during one operating cycle.

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
