# Community Operations SOP Contract

Use this contract when a recurring community action must be executed consistently by an operator, AI agent, automation, bot, API integration, or a combination of them.

The task contract defines what result is requested. This SOP contract defines how the action moves from trigger to verified record.

## SOP Template

```md
**Operation**
[A concrete repeated action.]

**Trigger**
[Schedule, threshold, owner request, lifecycle event, or verified signal.]

**Decision Owner**
[Who may approve, stop, change, or accept the result.]

**Inputs And Source Of Truth**
- [Required input, durable source, freshness rule, and data-gap behavior.]

**Judgment Rule**
- [How evidence changes the next action.]

**Execution Roles**
- Operator: [human judgment or action]
- AI/skill: [analysis, drafting, classification, or validation]
- Automation: [scheduled read-only or deterministic step]
- Platform adapter: [bot/API/integration action inside its permission scope]

**Procedure**
1. [Read and validate inputs.]
2. [Prepare the exact action or decision packet.]
3. [Obtain approval when required.]
4. [Execute once through the approved route.]
5. [Read the target system and verify the result.]
6. [Write the verified state and evidence back to the source of truth.]

**State**
[observed / scoped / prepared / pending approval / approved / executed / verified / recorded / reviewed]

**Approval Scope**
[Exact content, audience, target, amount, permission, configuration, and validity period.]

**Execution Receipt**
[Actor, target, approved version, timestamp, result, and non-sensitive evidence.]

**Verification**
[What must be read back or observed before completion is claimed.]

**Exceptions**
- Blocked: [known stop condition]
- Data gap: [missing evidence]
- Ambiguous: [external effect may have happened but cannot be confirmed]
- Cancelled: [owner or rule stopped the action]

**Review And Update**
[When the SOP is reviewed and what evidence can change it.]
```

## Completion Rule

Use this lifecycle:

```text
observed -> scoped -> prepared -> pending approval -> approved
-> executed -> verified -> recorded -> reviewed
```

- `prepared` means the action packet exists.
- `approved` means the exact shown action may proceed within its stated scope.
- `executed` means an execution attempt returned without enough proof to claim completion.
- `verified` means the target system or reliable evidence confirms the intended result.
- `recorded` means the verified result is written to the durable operating record.

If an external result is ambiguous, stop. Preserve the evidence and ask for verification. Do not retry when the first attempt may already have created a public, financial, permission, or user-facing effect.

## Approval Rules

Content review and execution approval are separate:

- content review confirms that wording, rules, or calculations are acceptable;
- execution approval authorizes the exact action, target, audience, amount, permission, or configuration.

A standing approval is valid only inside its documented scope. Stop when the target, content, amount, permission, risk, or execution route changes.

## Source And Report Rules

- Keep the durable operating record as the source of truth.
- Treat dashboards, daily reports, and weekly reviews as derived views.
- Write back only material state changes and minimum necessary evidence.
- Do not store credentials, webhook URLs, raw private messages, payment details, personal profiles, or unrelated user-level data.
