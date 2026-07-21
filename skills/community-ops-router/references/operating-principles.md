# Operating Principles

Use this reference when a diagnosis or plan needs sharper judgment than the router workflow alone provides.
Apply the rules in order; do not skip evidence classification to reach an action faster.

## Operating Rules

### 1. Establish Evidence Before Conclusions

- Inspect available counts, timestamps, artifacts, user reports, and prior outcomes before naming a problem.
- Record the source and observation period for any evidence that drives a decision.
- Separate every material statement into one of four states:
  - **Confirmed**: directly supported by a cited source or verified observation.
  - **Hypothesis**: a plausible interpretation that still needs a test.
  - **Data gap**: information required for confidence but not currently available.
  - **Pending approval**: a prepared action that a human must authorize.
- Do not turn an absence of evidence into evidence of absence.
- When evidence is weak, narrow the claim and propose a way to verify it.

### 2. Identify The Primary Friction

- Locate the exact step where the target user fails, stalls, repeats work, or leaves.
- Describe the friction as `segment + intended action + observed obstacle + evidence`.
- Rank competing frictions by user impact, frequency, reversibility, and confidence in the evidence.
- Select one primary friction for the current cycle; list other issues as secondary or unverified.
- If the main friction cannot be selected, collect the smallest missing dataset before designing a program.

### 3. Choose The Minimum Effective Action

- Choose the smallest intervention likely to change the target behavior and produce an observable signal.
- Define one target segment, one next action, one owner, and one review point.
- Prefer a reversible pilot when impact or evidence is uncertain.
- State the expected signal, failure condition, and stop condition before execution.
- Expand scope only after the pilot shows that the mechanism works or exposes a specific next constraint.

### 4. Give Each Surface One Primary Job

- Assign each channel, forum, event, message, form, or report one explicit operational job.
- Express that job as a user action, such as ask, submit, learn, decide, or review.
- Route unrelated actions to another surface instead of adding more instructions to the same place.
- Define the evidence that the surface should produce and who reviews it.
- If a surface has several competing calls to action, simplify it before adding traffic or content.

### 5. Keep Automation Inside Its Boundary

- Automation may collect, normalize, classify, summarize, draft reminders, and check.
- It may prepare previews, recipient lists, calculations, change sets, and approval packets.
- Require explicit human confirmation before public publishing, direct messages, rewards, permission changes, webhook changes, or official statements.
- Treat approval as specific to the exact content, audience, amount, permission, or configuration shown.
- After approval, preserve the approver, approved version, execution result, and timestamp when the system supports it.
- Stop and request review when the target, scope, or risk changes after approval.

### 6. Turn Every Action Into A Reviewable Loop

- Define the loop as `trigger -> action -> evidence -> response -> review -> next decision`.
- Capture a baseline or comparison point before the intervention when practical.
- Set a review date or event; "review later" is not a review rule.
- Record what happened, what remains uncertain, and whether to continue, change, or stop.
- Feed the decision back into the next cycle, documentation, or operating rule.

## Decision Questions

Ask these before recommending or routing work:

1. What is confirmed, and where is the supporting evidence?
2. Which statements are hypotheses, data gaps, or pending approvals?
3. Which user segment and lifecycle step are affected?
4. What single obstacle most prevents the next intended action?
5. What is the smallest reversible action that could reduce that obstacle?
6. What observable signal would support or reject the action?
7. Which surface owns this action, and what is that surface's one primary job?
8. Can automation prepare the work without crossing a human approval boundary?
9. Who reviews the result, when, and what decision will follow?

## Anti-Patterns

| Anti-pattern | Correction |
|---|---|
| Declaring a cause from one anecdote or a vanity metric | Label it as a hypothesis and seek corroborating behavior or records. |
| Treating every visible issue as equally urgent | Rank them and commit to one primary friction per cycle. |
| Launching a broad campaign before testing the mechanism | Run a small, reversible intervention with a defined signal. |
| Making one surface serve onboarding, support, promotion, and reporting | Assign one primary job and route the other actions elsewhere. |
| Letting automation send or change sensitive items because a draft exists | Present the exact action and wait for explicit human confirmation. |
| Reporting activity without a follow-up decision | Add a review owner, timing, evidence, and continue/change/stop rule. |
| Mixing facts, guesses, missing data, and approvals in one recommendation | Label each state and keep its next action distinct. |

## Output Check

Before returning a diagnosis, plan, or review, confirm that:

- [ ] Evidence sources and observation periods are named where material.
- [ ] Confirmed facts, hypotheses, data gaps, and pending approvals are visibly separated.
- [ ] One primary friction is stated for a specific segment and lifecycle step.
- [ ] The proposed action is the minimum effective, preferably reversible, intervention.
- [ ] Each surface has one primary job and one clear user action.
- [ ] Automated work is limited to collection, organization, reminder preparation, drafts, and checks.
- [ ] Sensitive execution is presented as pending human approval, not completed work.
- [ ] Success signal, failure condition, owner, and review timing are explicit.
- [ ] The next decision is defined as continue, change, stop, or gather more evidence.
- [ ] No claim is stronger than the evidence supporting it.
