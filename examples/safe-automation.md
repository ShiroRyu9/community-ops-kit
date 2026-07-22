# Example: Safe Report Automation

[Simplified Chinese](safe-automation.zh-CN.md)

## Prompt

```text
Use community-ops-automation-workflow to design a weekly process that collects activity counts, assembles a review draft, and flags missing evidence.

The process may read approved sources and prepare files. It may not send messages, publish reports, change roles, or settle rewards automatically.
```

## Expected Shape

- define inputs, allowed automation, evidence, output, success criteria, and failure checks;
- stop at a review draft when sources or targets are missing;
- include a dry run, retry limit, audit log, and human approval gate;
- keep public posting, role changes, and reward settlement outside automatic execution.
