# Example: SOP And Agent Handoff

This example uses synthetic aggregate records. It shows how one recurring community action moves from evidence to verified completion without assuming that an automation run equals a published result.

## Scenario

- A five-day learning activity has 14 valid entries.
- The operating rule says to prepare one reminder when valid entries remain below 20 on day 4.
- The owner must approve the exact message and target before publication.
- An integration can publish the reminder, but it may not change roles, send direct messages, or settle rewards.

## SOP Contract

**Operation**
Prepare, approve, publish, and verify the day-4 activity reminder.

**Trigger**
Day 4 and fewer than 20 valid entries in the verified activity record.

**Decision owner**
The community operator approves the exact reminder and target.

**Inputs and source of truth**

- activity record: day, valid-entry count, target surface, current reminder state;
- approved activity rules: reminder threshold and maximum frequency;
- missing or stale fields produce `data gap` and stop preparation.

**Execution roles**

- Operator: confirms the exact reminder and target.
- AI/skill: validates the trigger and prepares the reminder packet.
- Automation: checks the threshold and creates the approval item.
- Platform adapter: publishes once after approval and returns an execution receipt.

**Procedure**

1. Read the activity record and confirm day 4, 14 valid entries, and no prior reminder.
2. Prepare one reminder and mark it `pending approval`.
3. Record the owner's approval for the exact text and target.
4. Send the approved packet to the platform adapter once.
5. Read the target surface and confirm the reminder identifier and visible text.
6. Mark the action `verified`, write the receipt to the activity record, and include it in the next report.

## Handoff Packet

```text
operation: day-4 activity reminder
state: approved
evidence: 14 valid entries on day 4; no previous reminder
target: current activity surface
content: owner-approved reminder version
allowed route: configured platform adapter
success: one visible reminder matching the approved version
stop: changed target, changed content, missing approval, or prior reminder found
verification: read back the target surface
writeback: activity operating record
```

## Normal Result

```text
prepared -> pending approval -> approved -> executed
-> verified -> recorded -> reviewed
```

The daily report may say the reminder was published only after target read-back confirms it.

## Ambiguous Result

Suppose the adapter times out after submission.

1. Mark the attempt `ambiguous`.
2. Preserve the target, approved version, attempt time, and adapter response.
3. Do not submit the reminder again.
4. Read the target surface.
5. If the reminder exists, verify and record it. If it does not, return the decision to the owner before another attempt.

This prevents a timeout from creating duplicate public reminders.
