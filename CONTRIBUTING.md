# Contributing

Contributions are welcome when they improve a repeatable community operations workflow.

## Before Opening A Pull Request

1. Explain the repeated operator problem.
2. Show the trigger, input, operator judgment, output, evidence, and review rule.
3. Keep platform-specific roles, channels, rewards, policies, and permissions out of the reusable core.
4. Add or update an example or eval case.
5. Run `ruby scripts/validate.rb`.

Add a new skill only when the task has a distinct trigger, judgment pattern, and output. Extend an existing skill when the workflow already fits.

Do not include credentials, webhook URLs, raw private messages, personal profiles, private community data, or unsupported performance claims.
