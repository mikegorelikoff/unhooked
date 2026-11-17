# unhooked

**An agent workflow you can start, verify and resume in your Git repository.**

`hx` installs a pack of project skills and connects your coding agent. A skill describes the steps and the evidence each step needs. The agent does the work. The CLI serves the active step, runs its checks and records the result so the next session can pick up where you left off.

[Documentation](https://github.com/mikegorelikoff/unhooked/wiki) · [Workflow map](https://github.com/mikegorelikoff/unhooked/wiki/Workflow-map) · [All 40 skills](https://github.com/mikegorelikoff/unhooked/wiki/Skills) · [Download](https://github.com/mikegorelikoff/unhooked/releases/tag/v0.1.0-preview.1)

## Quick start

**Install the CLI.** The public preview has ready-to-run Apple Silicon and Intel packages. See [platform availability](https://github.com/mikegorelikoff/unhooked/wiki/Install-and-connect-agents#install-the-cli) for Linux and Windows.

```sh
curl -fsSL https://github.com/mikegorelikoff/unhooked/releases/download/v0.1.0-preview.1/install.sh -o install-unhooked.sh &&
  sh install-unhooked.sh &&
  export PATH="$HOME/.local/bin:$PATH" &&
  hx --version
```

**Set up a Git project.** Try it in a scratch repository first. `hx init --dry-run` previews the files. `hx init` asks for your agent and skill set and applies changes after confirmation.

```sh
mkdir hx-demo
cd hx-demo
git init
hx init
hx doctor
hx start .agents/skills/hx-tour
```

In the wizard, select the full pack to try the entire reference. Use `hx done` after completing a step. A failed check keeps you on that step. Use `hx resume` in a new session to continue the run from the same repository.

## What setup adds to a project

| Project file | What it does |
| --- | --- |
| `AGENTS.md` | Carries the managed instructions that tell the agent how to use the installed workflow. |
| `.agents/skills/` | Holds the skill definitions, step files and defaults. |
| `.agents/custom/` | Holds overrides and installation presets for a team or one user. |
| `.agents/hx/` | Stores local runs, events and evidence. |
| `.claude/settings.json` | Receives file-write and stop hooks when you select Claude Code. |

Claude Code gets skill links and hooks. Codex reads the common project instructions and skills and uses the same CLI gates. For another agent, you can expose the pack in its project skill directory. [Agent setup and hook behavior](https://github.com/mikegorelikoff/unhooked/wiki/Install-and-connect-agents#where-each-agent-reads-instructions)

## Choose a workflow

| What you have | Where to start |
| --- | --- |
| A rough idea or an unclear request | [Discovery and planning](https://github.com/mikegorelikoff/unhooked/wiki/Skills#discovery-and-planning) |
| A ticket that needs a checked specification | [hx-spec](https://github.com/mikegorelikoff/unhooked/wiki/hx-spec) |
| An approved spec and a change to make | [hx-implement](https://github.com/mikegorelikoff/unhooked/wiki/hx-implement) |
| A diff ready for review and verification | [Build and review](https://github.com/mikegorelikoff/unhooked/wiki/Skills#build-and-review) |
| A release that needs test evidence and a readiness decision | [QA and release](https://github.com/mikegorelikoff/unhooked/wiki/Skills#qa-and-release) |

If you know the task and want to find the skill, try `hx route "spec this ticket DEMO-42"`. For a sequenced workflow, see the [workflow map](https://github.com/mikegorelikoff/unhooked/wiki/Workflow-map) and [project flows](https://github.com/mikegorelikoff/unhooked/wiki/Project-flows).

## Learn how it works

- [First workflow](https://github.com/mikegorelikoff/unhooked/wiki/First-workflow) shows how to start and resume a run.
- [Runtime and gates](https://github.com/mikegorelikoff/unhooked/wiki/Runtime-and-gates) explains where execution happens and what the CLI checks.
- [Configuration](https://github.com/mikegorelikoff/unhooked/wiki/Configuration) explains team, user and per-run settings.
- [Artifacts](https://github.com/mikegorelikoff/unhooked/wiki/Artifacts) and [QA and evidence](https://github.com/mikegorelikoff/unhooked/wiki/QA-and-evidence) cover specs, tests and recorded results.
- [Troubleshooting](https://github.com/mikegorelikoff/unhooked/wiki/Troubleshooting) covers missing hooks, skills and failed gates.

Licensed under [Apache 2.0](LICENSE). See [NOTICE](NOTICE).
