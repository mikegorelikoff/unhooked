# Get started with hx

Use a test Git repository for your first run. From the repository root:

```sh
hx init
hx doctor
hx start .agents/skills/hx-tour
```

The setup wizard lets you choose an agent and a skill pack, previews the project changes and applies them after approval. Skills live in `.agents/skills`. The wizard adds a managed block to the project's `AGENTS.md`.

`hx start` shows the first step. When you finish the work for that step, run `hx done`. If a gate fails, `hx` reports what needs attention and keeps you on the current step. Run `hx status` to see where you are or `hx resume` to read the current step in a new session.

```sh
hx route "write a spec for DEMO-42"
hx validate
```

Use `hx route` to find the skill for a request. Use `hx validate` to check the installed skill definitions. The preview includes skills for planning, requirements, implementation, review, QA and release. Mutation testing and generated test candidates require compatible adapters configured in the project.

The Claude Code integration can set up hooks. Codex reads the installed skills and uses the CLI to check gates. Run and step state are stored under `.agents/hx/`. Telemetry export is opt-in.
