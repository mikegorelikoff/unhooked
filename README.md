# unhooked

unhooked gives coding agents a workflow they can follow, verify and resume. The `hx` CLI installs skills into a Git project, connects your agent and checks each step before the run moves on.

## Install hx

Anyone can download the current preview without a GitHub account. Prebuilt packages are available for Apple Silicon and Intel Macs. See the [installation guide](docs/install-and-agents.md#install-hx) for Linux and Windows availability.

```sh
curl -fsSL https://raw.githubusercontent.com/mikegorelikoff/unhooked/main/install.sh -o install-unhooked.sh
sh install-unhooked.sh
export PATH="$HOME/.local/bin:$PATH"
hx --version
```

## Set up your project

From a Git repository, run `hx init`. The wizard asks which agent and skill set to use, previews the files it will change and waits for confirmation.

```sh
hx init
hx doctor
hx start .agents/skills/hx-tour
```

Setup adds a managed block to `AGENTS.md` and installs the skill pack under `.agents/skills/`. Claude Code setup also links the skills and adds tool and stop hooks in `.claude/settings.json`. Codex reads the shared project instructions and skills, then uses `hx done` to check each step.

## Documentation

- [Installation, project files and agent integrations](docs/install-and-agents.md)
- [Your first run and the skill pack](docs/getting-started.md)
- [Preview downloads](https://github.com/mikegorelikoff/unhooked/releases/tag/v0.1.0-preview.1)
