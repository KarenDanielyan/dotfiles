# dotfiles

Cross-platform configurations managed with GNU Stow on Linux and a native PowerShell script on Windows.

## Repository Layout

```text
dotfiles/
├── zed/
│   └── .config/
│       └── zed/
│           ├── settings.json
│           └── keymap.json
│
├── agy/
│   └── .gemini/
│       └── config/
│           ├── config.json
│           └── mcp_config.json
│
├── agents/
│   └── .agents/
│       └── skills/
│           └── <skill-name>/
│               └── SKILL.md
│
├── bash/
│   └── .bashrc
│
├── vim/
│   └── .vimrc
│
├── scripts/
│   └── bootstrap-windows.ps1
│
├── CONTEXT.md
├── README.md
└── .gitignore

```

## Installation

### Linux

Deploy all packages:

```bash
cd ~/dotfiles
stow zed agy agents bash

```

Deploy specific packages:

```bash
stow zed agents

```

Remove symlinks:

```bash
stow -D zed agy agents bash

```

### Windows

Run the bootstrap script from PowerShell (requires Developer Mode or elevated privileges):

```powershell
cd $HOME\dotfiles
powershell -ExecutionPolicy Bypass -File .\scripts\bootstrap-windows.ps1 -Action Install

```

Deploy specific packages:

```powershell
.\scripts\bootstrap-windows.ps1 -Action Install -Packages @('zed', 'agents')

```

Remove symlinks:

```powershell
.\scripts\bootstrap-windows.ps1 -Action Uninstall

```
