# Platform Agent Patterns

Use these patterns to connect community judgment with operators, AI agents, schedulers, bots, APIs, and platform surfaces without binding the reusable workflow to one product.

## Role Model

| Role | Primary job | Must not assume |
|---|---|---|
| Operator / owner | Set priorities, approve sensitive actions, decide exceptions | That a prepared action was executed |
| AI / skill | Interpret evidence, apply judgment, draft, classify, validate | Final authority for public, financial, permission, or user-facing actions |
| Scheduler / automation | Trigger predictable reads, checks, calculations, and handoffs | Approval from timing alone |
| Platform adapter | Read or write through a bot, API, webhook, or integration within known permissions | Permission to every target or message on the platform |
| Durable record | Hold the latest verified state and minimum evidence | That a report is a newer source of truth |
| Report / dashboard | Present a derived view for decisions | Authority to overwrite the operating record |

## Handoff Packet

Before execution, prepare:

```text
operation
current state
trigger and evidence
exact target
exact content or change
allowed execution route
approval and validity scope
success condition
stop condition
verification method
writeback destination
```

Do not include credentials, private-message bodies, unnecessary member profiles, or unrelated user-level data.

## Execution Receipt

After an attempt, preserve:

```text
actor or adapter
approved version
target
attempt time
returned result
external identifier when safe
verification status
correction or rollback state
```

An API success response is supporting evidence, not always final verification. Read the target surface when practical.

## Common Patterns

### Read-Only Sensor

```text
schedule or owner request -> platform read -> normalize minimum fields
-> evidence packet -> AI/operator judgment -> durable record
```

Use for activity status, aggregate participation, missing-field checks, support queues, or public content observations.

### Owner-Reviewed Action

```text
verified signal -> AI prepares exact action -> owner approves exact scope
-> adapter executes once -> target is read back -> receipt is recorded
```

Use for public posts, reminders, mentions, rewards, permissions, integrations, or official claims.

### Draft And Human Execution

```text
verified signal -> AI prepares copy/checklist -> owner approves
-> human executes -> operator or adapter verifies -> record is updated
```

Use when a personal account, sensitive judgment, or unsupported platform action requires manual execution.

### Ambiguous External Result

```text
execution attempt -> timeout, permission conflict, or unclear response
-> mark ambiguous -> preserve evidence -> verify target -> owner decides next action
```

Do not retry until the target is checked. This prevents duplicate posts, repeated rewards, conflicting role changes, and duplicated messages.

## Adapter Boundary

Platform names, channel IDs, role names, tokens, webhook URLs, reward rules, and permission configuration belong in the project adaptation layer. The public skill should describe role, input, output, state, approval, and verification requirements without embedding those values.
