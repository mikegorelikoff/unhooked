# Run your first workflow

[Install hx and set up your agent](install-and-agents.md) in a test Git repository. Then run:

```sh
hx start .agents/skills/hx-tour
hx status
```

`hx start` opens a run and shows its first step. Follow the step, then run `hx done`. The CLI runs the required checks and gives you the next step if they pass. If a check fails, it explains why and leaves you on the current step. Start a new session and use `hx resume` to pick up from the state in `.agents/hx/`.

## Pick a skill

Try `hx route "spec this ticket DEMO-42"` to see which skill matches a request. Use `hx init` with the full pack for access to all the categories below.

| Work | Example skills |
| --- | --- |
| Discovery and planning | `hx-idea`, `hx-prfaq`, `hx-story-map`, `hx-sprint-plan` |
| Specification and design | `hx-spec`, `hx-spec-review`, `hx-architecture` |
| Delivery and review | `hx-implement`, `hx-quality-gate`, `hx-code-review`, `hx-verify`, `hx-commit` |
| QA and release | `hx-test-cases`, `hx-qa`, `hx-test-gen`, `hx-release` |
| Workflow routing and improvement | `hx-flow`, `hx-orchestrate`, `hx-skill-eval`, `hx-improve` |

A typical ticket starts with a spec and its review, then moves through test planning, implementation, verification and any required approvals. Use `hx validate` to check installed definitions and flows. Mutation testing and generated test candidates require adapters configured in the project.

To adjust an installed skill, put overrides under `.agents/custom/`. Keep the bundled skill as the baseline so that updates can still be previewed and reviewed.
