# Example: Newcomer Activation

[Simplified Chinese](newcomer-activation.zh-CN.md)

## Prompt

```text
Use community-ops-router to diagnose why people join the community but rarely complete a first action.

Known facts:
- the welcome page contains seven links;
- new members can read the main discussion area;
- first-post and day-seven return data are not currently tracked.

Give me the smallest useful changes, the specialist skill to use, evidence to collect, and any approval boundaries.
```

## Expected Route

The router should identify onboarding as the primary path and route focused work to `community-ops-onboarding`.

## Expected Shape

- name the current friction without inventing conversion data;
- propose one first action and assign one job to each relevant surface;
- preserve unknown access and role rules as data gaps;
- define first-action and return evidence;
- avoid rewriting every channel or adding unrelated campaigns.
