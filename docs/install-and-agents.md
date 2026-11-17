# Install hx and connect an agent

## Install hx

The public preview downloads are available without a GitHub account.

| Platform | Installation |
| --- | --- |
| macOS on Apple Silicon or Intel | Use the [public installer](../README.md#quick-start). It detects the architecture, verifies the archive and installs `hx` in `~/.local/bin`. |
| Linux and Windows | The preview has no public prebuilt packages for these platforms yet. If you already have access to the source checkout, run `cargo install --locked --path crates/unhooked-cli` from its root with Rust 1.96 or newer. |

Verify with `hx --version`. Add the installation directory to `PATH` in the shell that launches your agent so the hooks can find `hx`. Set `HX_INSTALL_DIR` before running the public installer to choose a different location. Persist the path in your shell configuration to make it available in new terminals.

The binaries declare macOS 11.0 for Apple Silicon and macOS 10.12 for Intel as deployment targets. Preview tests ran on macOS 26.3.1, with the Intel build running under Rosetta.

## Preview the project setup

Run these from the root of a Git repository:

```sh
hx init --dry-run
hx init
hx doctor
```

The wizard asks where specs should live, which agents to connect, which skills to install, how to render artifacts and whether to export telemetry. Choose `basic` for the core skills, `full` for the entire pack or `custom` for named skills. For a new test repository, you can select options explicitly:

```sh
hx init --yes --storage repo --agents claude,codex --skill-set full --docs md --telemetry off
```

## What hx installs

| Path | Purpose |
| --- | --- |
| `AGENTS.md` | Project instructions for the agent. `hx` maintains only the block between its markers. |
| `.agents/skills/hx-*/` | Installed skills. Each skill includes a `SKILL.md`, step files and `customize.toon` defaults. |
| `.agents/custom/` | Project overrides and installation choices. The team uses `install.toon`; personal choices go in `install.user.toon`. |
| `.agents/hx/` | Local run folders, event log and installation record. |
| `.gitignore` | A managed block for local runtime files and user-specific configuration. |

## Claude Code

Choose Claude Code in the wizard or use `hx init --agents claude`. Setup links the skills into `.claude/skills/`, links `CLAUDE.md` to `AGENTS.md` when missing and merges two hooks into `.claude/settings.json`. An existing `CLAUDE.md` stays in place by default. Run `hx init --agents claude --claude-md import` to add a managed `@AGENTS.md` import to it.

- `PreToolUse` checks supported file-write tools against the active step's `## Allowed` block when it declares one. During an unfinished run it also protects `.agents/hx/` from these write tools. Shell commands are outside the hook's scope. An internal hook error is reported and lets the agent continue.
- `Stop` asks Claude Code to finish the active step before ending its turn. It skips runs halted on a question.

## Codex and other agents

Select Codex with `hx init --agents codex`. Codex reads `AGENTS.md` and `.agents/skills/` directly. The Codex adapter records setup and uses the same CLI gates without adding Claude-style hooks.

For an agent that needs skills in another project folder, use `hx init --skills-root .tools/skills`. This creates one link or generated copy per skill in the alternate directory. The canonical skill and standard `hx start` path stay under `.agents/skills/`. Use `hx sync` to refresh generated copies.

## Maintain the installation

- `hx doctor` checks installed files, the managed instructions, links or copies, hooks and `PATH`.
- `hx sync` repairs managed files and refreshes generated copies.
- `hx update --dry-run` previews pack changes once you have upgraded the binary.
- Commit `.agents/custom/install.toon` to share the team's setup choices. Teammates can then run `hx init` using the same preset.
