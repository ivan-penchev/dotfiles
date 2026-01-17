{ config, pkgs, lib, ... }:

{
  networking.hostName = "MacbookAir";

  # Enable Shell Features
  ivan-config-options.shell.zsh.enable = true;
  ivan-config-options.shell.git.enable = true;
  
  # Enable Utils
  ivan-config-options.utils.enable = true;
  
  # Enable Development Packages
  ivan-config-options.development-packages.enable = true;
  ivan-config-options.development-packages.tools.python = true;
  ivan-config-options.development-packages.tools.dev = true; # node, jq, etc.
  
  # Personal stuff
  ivan-config-options.apps.vscode.enable = true;
  
  # Add Spotify via Homebrew for Personal machine
  homebrew.casks = [
    "spotify"
  ];
}
