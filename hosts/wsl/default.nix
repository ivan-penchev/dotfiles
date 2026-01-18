{ config, pkgs, lib, ... }:

{
  # Enable Shell Features
  ivan-config-options.shell.zsh.enable = true;
  ivan-config-options.shell.git.enable = true;
  
  # Enable Utils
  ivan-config-options.utils.enable = true;
  
  # Enable Development Packages
  ivan-config-options.development-packages.enable = true;
  ivan-config-options.development-packages.tools.dev = true;
  ivan-config-options.development-packages.tools.python = true;
  
  # Enabled as requested
  ivan-config-options.development-packages.tools.go = true;
  ivan-config-options.development-packages.tools.k8s = true;
  ivan-config-options.development-packages.tools.ai = true;

  ivan-config-options.apps.vscode.enable = false; # VSCode is better on Windows side
  
  # Enable requested apps for testing
  ivan-config-options.apps.discord.enable = true;
  ivan-config-options.apps.vlc.enable = true;
  ivan-config-options.apps.bitwarden.enable = true;

  # Enable WSL
  wsl.enable = true;

  system.stateVersion = "25.11";
}