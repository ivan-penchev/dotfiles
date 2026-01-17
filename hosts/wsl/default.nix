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
  ivan-config-options.development-packages.tools.python = true; # Maybe you code in python on WSL

  ivan-config-options.apps.vscode.enable = false; # VSCode is better on Windows side

  # Enable WSL
  wsl.enable = true;

  system.stateVersion = "24.05";
}