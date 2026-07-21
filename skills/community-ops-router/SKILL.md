---
name: community-ops-router
description: Use when diagnosing, designing, coordinating, or reviewing an end-to-end community operations system; when a request spans onboarding, activities, creators, paid members, reports, automation, support risk, or operator writing; or when the correct specialist community-ops skill is unclear. Produces a routed workflow with user segment, friction, next action, surface, evidence, feedback loop, review rhythm, and approval boundaries.
---

# Community Ops Router

Use this skill as the entry point for cross-functional community operations work.

## Operating Model

```text
community goal
-> user segment
-> current friction
-> next user action
-> surface
-> proof/evidence
-> feedback, support, recognition, or reward
-> review and next decision
```

Start with the user path and operating evidence. Do not begin with channel decoration, generic engagement tactics, or a long list of content ideas.

## First Move

Classify the request:

1. **Diagnose**: find the main break in the community lifecycle.
2. **Design**: build an operating loop, user path, or coordinated plan.
3. **Route**: send a concrete task to the smallest specialist skill.
4. **Review**: combine evidence, risks, decisions, and next actions across skills.

For multi-step work, define a lean task contract: goal, relevant context, hard constraints, required evidence, success criteria, output format, approval boundary, and stop/question conditions. See [task-contract.md](references/task-contract.md).

## Skill Routing

- activity, campaign, challenge, submissions, voting, rewards, reminders, or results -> `community-ops-activity`;
- onboarding, welcome, routing, first action, activation, or early retention -> `community-ops-onboarding`;
- creators, contributors, UGC, showcases, tutorials, cases, attribution, or reusable content -> `community-ops-creator-assets`;
- paid, premium, VIP, high-value, benefits, renewal, entitlement, or priority support -> `community-ops-paid-members`;
- daily work log or daily recap -> `community-ops-daily-report`;
- weekly metrics, retrospective, decisions, or next-week priorities -> `community-ops-weekly-review`;
- support, moderation, privacy, payment, access, permissions, rewards disputes, bots, or official claims -> `community-ops-support-risk`;
- recurring collection, drafting, reminders, reports, checks, handoffs, or audit trails -> `community-ops-automation-workflow`;
- announcements, reports, articles, stakeholder writing, or natural operator voice -> `community-ops-expression`.

If several areas are involved, keep this router as the synthesis layer and use specialist skills only for their part of the work.

## Workflow

### 1. Establish The Operating Context

Identify:

- community type and goal;
- target user segment;
- lifecycle stage;
- available surfaces and tools;
- confirmed evidence and data gaps;
- public, financial, permission, safety, or privacy boundaries.

Use [community-patterns.md](references/community-patterns.md) for transferable defaults when project evidence is limited.

### 2. Find The Main Friction

Map the lifecycle:

```text
discovery -> entry -> first action -> repeat participation -> contribution -> recognition -> retention/upgrade -> review
```

Choose the smallest useful intervention. Name where it happens and what proof shows whether it worked.

### 3. Route And Produce

For each routed task, require:

```text
trigger -> input -> operator judgment -> output -> evidence -> review rule
```

Keep confirmed actions, drafts, assumptions, and missing data separate.

### 4. Close The Loop

Every plan should specify:

- one next user action;
- feedback, support, recognition, reward, or follow-up;
- evidence collected;
- review timing;
- decision owner;
- what changes after the review.

## Approval Boundary

The agent may read, organize, compare, calculate, draft, and prepare checklists when allowed. Require explicit confirmation before public posts, DMs, user mentions, rewards, discounts, paid-benefit promises, role or permission changes, bot or webhook changes, winner lists, deletions, or official claims.

## Output Pattern

```md
**Diagnosis**
[The main operating friction and affected segment.]

**Target Loop**
entry -> action -> proof -> feedback/support -> next action -> review

**Routed Actions**
| Priority | Specialist skill | Action | Surface | Evidence | Owner gate |
|---|---|---|---|---|---|

**Data Gaps**
- ...

**Success Criteria**
- ...

**Next Review**
- Timing: ...
- Decision: ...
```

## Quality Bar

Reject plans that rely only on message volume, vague engagement goals, or unsupported growth claims. Prefer concrete actions, visible evidence, clear ownership, and a repeatable review loop.
