# Ivan's NixOS & Darwin Configuration

This repository contains the system configuration for my three machines:
- **WSL (NixOS)**: Windows Subsystem for Linux
- **Macbook Air**: Personal machine
- **Macbook Pro**: Work machine

## Structure

The configuration is modular:
- `flake.nix`: Entry point defining the machines.
- `hosts/`: Machine-specific configurations (toggling features).
- `modules/`: Reusable configuration modules (Zsh, VSCode, Dev Packages).

## Usage

### 1. WSL (NixOS)

Inside your NixOS WSL instance, navigate to this directory:

```bash
#If no git enabled in the image
wsl -d NixOS -- nix-env -iA nixos.git
# Apply the configuration
sudo nixos-rebuild switch --flake .#NixOS
```

### 2. macOS (Darwin)

On your Mac, ensure `nix` and `nix-darwin` are installed, then navigate to this directory:

```bash
# Personal Macbook Air
darwin-rebuild switch --flake .#MacbookAir

# Work Macbook Pro
darwin-rebuild switch --flake .#MacbookPro
```

## Customization

To enable/disable features, edit the file corresponding to your host in `hosts/<machine>/default.nix`.
For example, to enable Python tools on the Work machine, edit `hosts/pro/default.nix`:

```nix
ivan-config-options.development-packages.tools.python = true;
```
