# Architecture & Design Philosophy

This repository is designed using a **Modular, Option-Based Architecture**. 
Instead of having one giant configuration file, the configuration is split into small, reusable pieces (Modules) that can be turned on or off (Toggled) for each specific machine (Hosts).

## High-Level Concept

Think of this structure like a **Menu** and an **Order**.

1.  **Modules (`modules/`)**: This is the **Menu**. It lists everything that is *possible* to install or configure (Zsh, Git, VSCode, Python, Kubernetes tools). It defines *how* to install them, but it doesn't install them by default.
2.  **Hosts (`hosts/`)**: This is the **Order**. Each file here represents a physical computer. It looks at the menu and says "I want Zsh, Git, and Python, but I do *not* want Kubernetes."
3.  **Flake (`flake.nix`)**: This is the **Waiter**. It connects the Order to the Kitchen (Nixpkgs) to deliver the final system.

---

## Directory Structure Breakdown

### 1. The Entry Point: `flake.nix`
This is the brain of the operation. It does three things:
- **Inputs**: Downloads dependencies (NixOS, Home Manager, Darwin).
- **Wiring**: It connects the `modules` folder to every host so they can use the custom options.
- **Outputs**: It defines the 3 specific machines (`NixOS` for WSL, `MacbookAir`, `MacbookPro`).

### 2. The Library: `modules/`
This directory contains the logic. Code here is "lazy" — it does nothing unless a Host enables it.

- **`options.nix`**: Defines the custom `ivan-config-options` namespace. This is the contract that allows Hosts to talk to Modules.
- **`system/`**: Low-level operating system configurations.
    - `common.nix`: Settings shared by EVERY machine (Timezone, Flakes support).
    - `darwin.nix`: Settings only for Macs (Dock, Finder, Homebrew).
    - `wsl.nix`: Settings only for Windows Subsystem for Linux.
- **`shell/`**: Terminal environment configuration.
    - `zsh.nix`: Oh-My-Zsh, plugins, theme.
    - `git.nix`: Git identity, aliases, config.
- **`development/`**: The most powerful part. It defines "Stacks".
    - `packages.nix`: Logic that says "If `tools.python` is enabled, install `python3` and `uv`".
- **`apps/`**: GUI Applications.
    - `vscode.nix`: VSCode settings and extensions.

### 3. The Instances: `hosts/`
These files are simple. They contain almost no logic, only **Settings**.

**Example: `hosts/pro/default.nix` (Work Mac)**
```nix
{
  # I am a Work Mac
  networking.hostName = "MacbookPro";

  # I want these features from the Menu:
  ivan-config-options.development-packages.tools.go = true;
  ivan-config-options.development-packages.tools.k8s = true;
  ivan-config-options.apps.vscode.enable = true;
}
```

**Example: `hosts/air/default.nix` (Personal Mac)**
```nix
{
  # I am a Personal Mac
  networking.hostName = "MacbookAir";

  # I do NOT want Kubernetes or Go.
  # But I DO want Spotify.
  homebrew.casks = [ "spotify" ];
}
```

## Data Flow

1.  **User runs command**: `nixos-rebuild switch --flake .#NixOS`
2.  **`flake.nix`** starts building the `NixOS` output.
3.  It loads **`modules/default.nix`**, making all `ivan-config-options` available.
4.  It loads **`hosts/wsl/default.nix`**.
    - This file sets `ivan-config-options.shell.zsh.enable = true`.
5.  **`modules/shell/zsh.nix`** sees that option is `true`.
    - It triggers `programs.zsh.enable = true`.
    - It configures Oh-My-Zsh.
6.  **Nix** builds the final system closure and switches to it.

## Why this split?

1.  **Separation of Concerns**: The "What" (Host) is separated from the "How" (Module). You don't see ugly `if/else` logic in your host files.
2.  **Scalability**: Adding a new tool (e.g., Rust) requires adding it to one place (`modules/development/packages.nix`). You can then toggle it on for any machine in one line.
3.  **Cross-Platform**: The `modules/system` folder isolates Windows vs Mac logic, so your shared config (`shell`, `apps`) works perfectly on both without conflicts.
