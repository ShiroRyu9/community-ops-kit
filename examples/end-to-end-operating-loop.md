# Example: End-to-End Community Operating Loop

This worked example uses synthetic, aggregate records. Every number below comes from the sample input. Missing facts stay marked as data gaps.

## 1. Beginner Prompt

```text
Use community-ops-router to turn these messy weekly notes into an operating loop.
Route focused work to onboarding, activity, creator-assets, automation-workflow,
daily-report, and weekly-review. Separate facts, drafts, decisions, and unknowns.

Community: a platform-neutral product-learning community.
Goal: help newcomers complete a useful first action and create reusable learning examples.

Monday: 38 newcomers entered this week. The cohort tracker shows 9 completed the
first-action marker. The welcome page has five links and no single primary action.
Monday: an operator published a five-day beginner prompt: share one product example
with a screenshot and one sentence about the result. No reward was offered.
Tuesday: 2 newcomers asked where to submit. A reminder was drafted but the notes
do not show that it was published. One submission looked suitable for a tutorial;
reuse permission and preferred attribution are unknown.
Friday: the activity record closed with 11 valid submissions from 8 participants;
5 participants were first-time posters. No showcase or winner post was published.
Sunday: day-7 return, traffic source, product usage, timezone, and member-level links
were not recorded. There were no reported safety, payment, or access incidents.

Constraints: use aggregate evidence only. Do not publish, message members, promise
rewards, change access, or reuse member work. Prepare drafts and owner decisions.
```

## 2. Router Output

**Diagnosis**
The main friction is the newcomer path: five equal links leave the first action unclear, and 2 newcomers asked where to submit. The activity still produced 11 valid submissions, including 5 first-time posters, so it is a useful activation surface. Retention impact is unknown because day-7 return was not tracked.

**Target loop**

entry -> one starter action -> submission proof -> feedback -> approved showcase -> second action -> weekly review

**Routed actions**

| Priority | Specialist | Concrete output | Evidence used | Owner gate |
|---|---|---|---|---|
| P0 | `community-ops-onboarding` | One first-action path from welcome to submission | 38 entrants, 9 markers, 2 questions | Approve public welcome changes |
| P0 | `community-ops-activity` | Repeatable beginner prompt with exact proof and support path | 11 valid submissions, 8 participants, 5 first-time posters | Approve launch and any reward |
| P1 | `community-ops-creator-assets` | Candidate record and permission request draft | 1 tutorial candidate | Approve contact, attribution, and reuse |
| P1 | `community-ops-automation-workflow` | Read-only collection and report-draft workflow | Cohort tracker, activity record, operator notes | Approve every external action |
| P1 | `community-ops-daily-report` | Friday operator record | Confirmed Friday state | None for local draft; approve distribution |
| P1 | `community-ops-weekly-review` | Evidence-based review and next decisions | All supplied aggregate records | Approve recommendations before execution |

## 3. Specialist Outputs

**Onboarding output**

- Segment: newcomers ready to try the product; first action: submit one screenshot plus one result sentence.
- Path: entry -> choose "Try the starter task" -> open the current activity -> submit -> receive review status -> try a second task.
- Surface change draft: make the starter task the primary welcome action and move the other four links under optional resources.
- Evidence next round: entrants, first-action markers, valid first submissions, help questions, and day-7 returns from the same cohort.
- Data gaps: current access rules, editable surfaces, timezone, and whether the 9 markers include the 5 first-time activity participants.

**Activity output**

- Goal: collect beginner examples that prove a completed first action.
- Mechanics draft: five-day window; one screenshot plus one result sentence; review for validity; feedback status recorded; showcase only after permission.
- Reminder draft: "The starter task closes Friday. Add one screenshot and one sentence about what happened in the activity submission area."
- Review evidence: 11 valid submissions, 8 participants, 5 first-time posters, 2 routing questions, and 1 possible tutorial.
- Data gaps: exact dates, timezone, submission surface, eligibility rules, reviewer, and any future reward.

**Creator-assets output**

| Item | Value | Permission/status | Next step |
|---|---|---|---|
| Tutorial candidate | Shows a complete beginner workflow | Reuse and attribution unknown | Draft a permission request; owner approves contact |

No showcase copy is finalized until approved use, visibility, attribution, and revocation handling are recorded.

**Automation-workflow output**

- Input: aggregate cohort tracker, activity record, operator notes, and permission-status field.
- Automated steps: validate required fields, deduplicate aggregate records, calculate supplied counts, flag gaps, and draft daily and weekly reports.
- Human approval gate: any public post, direct message, member mention, reuse, reward, role/access change, or official metric claim.
- Output/log: local draft, source name, collection time, missing-field list, and approval status; store no raw private messages or profiles.
- Stop condition: missing source, unclear cohort definition, missing target surface, or any external action. Retry read-only collection once; never retry an ambiguous external action.

## 4. Friday Daily Report Output

**Focus:** Closed the beginner activity record and separated confirmed results from pending creator work.

**Completed:** The record contains 11 valid submissions from 8 participants; 5 participants were first-time posters. No showcase or winner post was published.

**In progress:** One tutorial candidate needs a reviewed permission request. The reminder exists only as a draft because publication evidence is missing.

**Data/observation:** Two newcomers asked where to submit. Day-7 return, product usage, timezone, member-level links, and overlap between the 9 first-action markers and 5 first-time participants are missing.

**Risk/approval:** Owner approval is required before creator contact, attribution, reuse, public reporting, rewards, or access changes.

**Next action:** Prepare the simplified first-action path and add cohort-aligned fields for the next run.

## 5. Weekly Review Output

**Weekly judgment:** The beginner prompt created visible first actions, while the welcome route and measurement setup remain incomplete. No retention conclusion can be made.

**Scope:** One synthetic week; timezone missing; sources are the cohort tracker, activity record, and operator notes.

| Area | Confirmed evidence | Decision |
|---|---|---|
| Entry | 38 newcomers; welcome has five equal links | Approve one primary starter action |
| Activation | 9 first-action markers; cohort overlap is unknown | Define one cohort rule before comparing rates |
| Participation | 11 valid submissions from 8 people; 5 first-time posters | Repeat the prompt after routing fixes |
| Creator asset | 1 tutorial candidate; permission unknown | Approve a permission-request draft or leave unused |
| Retention | Day-7 return and product usage missing | Add tracking; make no retention claim |

**Next-round decisions**

1. P0, owner before next activity: approve the welcome change and exact submission surface.
2. P0, operator before launch: define cohort, timezone, first-action, and day-7 fields; run a read-only dry run.
3. P1, owner after review: decide whether to contact the tutorial creator for scoped permission.
4. P1, operator at next weekly review: compare the new cohort only after the required fields are complete; keep counts and conclusions as data gaps otherwise.

The loop closes when the owner records these decisions, the operator runs the approved next activity, automation collects the same evidence schema, and the next weekly review decides whether to keep, revise, or stop the intervention.
