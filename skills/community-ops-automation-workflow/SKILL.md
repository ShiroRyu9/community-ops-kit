---
name: community-ops-automation-workflow
description: Use when designing, reviewing, or documenting community-operations automation, including recurring data collection, report assembly, activity reminders, draft generation, status-board updates, skill/version checks, tool handoffs, dry-runs, audit trails, and owner approval gates. Trigger on requests about "社区自动化", "自动化流程", "日报/周报自动化", "提醒自动化", "检查更新", "对比版本", "把重复动作交给工具", or safe AI-assisted community ops.
---

# Community Ops Automation Workflow

## Overview

Use this skill to turn repeated community-ops work into a safe automation workflow. The default model is:

```text
repeated task -> input source -> automated collection/draft/check -> human approval gate -> output/log -> review/update
```

Automation should reduce repeated labor and improve review quality. Keep public, financial, permission, reward, role, and official-claim actions under explicit human approval.

## Workflow

### 1. Name The Repeated Task

Start by identifying the actual operator action:

- collect community signals;
- prepare a daily or weekly report;
- draft activity/reminder/result copy;
- compare skill versions or stale modules;
- update a local status board;
- prepare a creator or high-value user follow-up list;
- check risk, permissions, rewards, or benefit claims.

Do not automate a vague goal such as "increase engagement." Turn it into a concrete repeated task first.

### 2. Split The Workflow

For each task, define:

- **inputs**: channels, posts, files, reports, metrics, user-provided notes, or prior skill files;
- **allowed automation**: read, collect, summarize, classify, draft, compare, prepare reminders, create non-destructive local archives, or produce a checklist;
- **human gate**: what the owner must review before execution;
- **output**: report, draft, checklist, version diff, action list, or archive note;
- **evidence**: IDs, links, timestamps, counts, source files, or "data missing";
- **success criteria**: what must be true for the workflow to be complete;
- **stop/question condition**: when to stop, ask, or return a structured data gap;
- **retry limit**: which transient failure may be retried and how many times;
- **failure mode**: missing source, stale data, ambiguous target, permissions risk, or public-action risk.

### 3. Choose The Execution Route

Use bounded code or batch tool processing for predictable filtering, joining, ranking, deduplication, aggregation, or validation when the input fields and output schema are known.

Use direct model/tool calls or human review when an intermediate result changes the next judgment, approval is required, source citations or native artifacts must be preserved, or the final result needs semantic validation.

Define one handoff between the two routes. Do not repeat completed calls or switch routes without a new reason.

### 4. Decide What Can Run Automatically

Safe default automation:

- read-only collection;
- draft generation;
- report assembly;
- reminder preparation only;
- version comparison;
- non-destructive local archiving of approved, non-sensitive materials;
- checklist creation;
- data-gap detection.

Do not archive credentials, webhook URLs, raw private messages, personal profiles, payment details, or unnecessary user-level data. Store only the minimum evidence needed for the stated workflow.

Require explicit approval before:

- public posts or announcements;
- DMs or user mentions;
- rewards, winner lists, discounts, or benefit promises;
- role, channel, permission, webhook, or bot changes;
- official metrics, revenue claims, or public commitments;
- handling disputes or payment/access issues.

### 5. Add Dry-Run And Review

For workflows with any external effect, include:

- dry-run mode;
- exact target list;
- preview output;
- owner confirmation point;
- execution log;
- rollback or correction note where applicable.

If exact targets are missing, stop at a draft or checklist.

Do not retry an action when the first attempt may already have caused an external effect and its status is ambiguous. Stop, preserve the evidence, and ask the owner to verify the target system.

### 6. Produce The Automation Map

Use this format:

```text
Workflow:
Input:
Automated steps:
Human approval gate:
Output:
Evidence/log:
Success criteria:
Stop/question condition:
Retry limit:
Direct judgment or final validation:
Failure checks:
Review rhythm:
```

## Output Rules

Keep the answer operational. Name what the tool does, what the human decides, and what artifact is produced. If a requested automation crosses a sensitive boundary, propose a safer workflow that stops at draft, dry-run, checklist, or owner review.
