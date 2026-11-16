# unhooked for macOS

`hx` is a CLI for running coding-agent work in steps that you can inspect, verify and resume. This preview is available for Apple Silicon and Intel Macs.

Download and run the installer:

```sh
curl -fsSL https://raw.githubusercontent.com/mikegorelikoff/unhooked/main/install.sh -o install-unhooked.sh
sh install-unhooked.sh
export PATH="$HOME/.local/bin:$PATH"
hx --version
```

The installer downloads and reassembles the archive for your Mac, verifies its SHA-256 checksum and installs `hx` in `~/.local/bin`. Set `HX_INSTALL_DIR` to choose another destination. Add the PATH line to your shell configuration if you want `hx` to be available in new terminals.

In a Git project, run `hx init` and review the changes it proposes. Start with [the getting started guide](docs/getting-started.md).

[Preview downloads](https://github.com/mikegorelikoff/unhooked/releases/tag/v0.1.0-preview.1)
