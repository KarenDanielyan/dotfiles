# CONTEXT.md

> Domain vocabulary and system definitions for the dotfiles architecture.

## Domain Terms

### Stow Package
* **Definition:** A top-level directory in the dotfiles repository containing a directory hierarchy that mirrors the target filesystem relative to the target root.
* **Scope:** Managed exclusively via GNU Stow symlinks.
* **Constraint:** Must not contain machine-local state, secrets, or transient runtime databases.

### ACP Host (Zed)
* **Definition:** The Agent Client Protocol (ACP) client application that provides the graphical user interface, editor buffer context, and workspace session orchestration.
* **Config Path:** `~/.config/zed/` (Linux) / `%APPDATA%\Zed\` (Windows).
* **Boundaries:** Governs session-level model selection, prompt execution, and workspace boundaries; delegates background tool execution and agent capabilities to configured ACP servers.

### Standalone Agent Runtime (Agy)
* **Definition:** The Antigravity CLI binary (`agy` / `agy.exe`) and headless server runtime.
* **Config Path:** `~/.gemini/antigravity-cli/`
* **Boundaries:** Operates independently of any editor UI. Manages system-level tools, global MCP servers, authentication credentials, and CLI workflows.

### Root Agent Skills Directory (`.agents`)
* **Definition:** An ecosystem-standard repository for modular agent instruction sets (`SKILL.md` files).
* **Hierarchy:** `~/.agents/skills/<skill-name>/SKILL.md` (Global) or `<project-root>/.agents/skills/` (Local).
* **Precedence:** Local project skills override global skills.
* **Decoupling:** Independent of editor or runtime configuration roots (`.gemini/` or `.config/zed/`).

### Canonical Gemini Runtime Path
* **Definition:** The standard configuration and runtime directory (`~/.gemini/antigravity-cli/`) targeted by the `agy` Stow package.
* **Contents:** `config.json` (runtime defaults) and `mcp_config.json` (global MCP server definitions).

### Host Stow Target
* **Definition:** The root directory passed to `stow -t <path>` designating the symlink destination.
* **Values:** `$HOME` (Native Linux) or `/mnt/c/Users/<username>` (WSL targeting Windows host).

### XDG Bridge Link
* **Definition:** An OS-level directory junction on Windows linking non-XDG application directories to their XDG equivalent.
* **Mapping:** `%APPDATA%\Zed` $\rightarrow$ `%USERPROFILE%\.config\zed`
* **Purpose:** Enables Windows native binaries to consume dotfiles structured in XDG layout without path translation.

### Windows Bootstrap Script
* **Definition:** The PowerShell script (`scripts/bootstrap-windows.ps1`) executed once on a Windows host prior to stowing from WSL.
* **Responsibility:** Creates required directory trees and establishes directory junctions. Does not manage symlinks handled by Stow.
