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
  ivan-config-options.development-packages.tools.dev = true; 
  
  # Personal stuff
  ivan-config-options.apps.vscode.enable = true;
  ivan-config-options.apps.qbittorrent.enable = true;
  
  # Spotify via Nixpkgs (might be Linux only or broken on Darwin, but user asked for Nix only)
  # environment.systemPackages = [ pkgs.spotify ]; 
}