{ config, pkgs, lib, ... }:

{
  networking.hostName = "MacbookPro";

  # Enable Shell Features
  ivan-config-options.shell.zsh.enable = true;
  ivan-config-options.shell.git.enable = true;
  
  # Enable Utils
  ivan-config-options.utils.enable = true;
  
  # Enable Development Packages
  ivan-config-options.development-packages.enable = true;
  ivan-config-options.development-packages.tools.go = true;
  ivan-config-options.development-packages.tools.python = true;
  ivan-config-options.development-packages.tools.k8s = true;
  ivan-config-options.development-packages.tools.cloud = true;
  ivan-config-options.development-packages.tools.dev = true;
  
  # Work stuff
  ivan-config-options.apps.vscode.enable = true;

  # Apps via Nixpkgs
  environment.systemPackages = with pkgs; [
    slack
    zoom-us
    # docker # Docker Desktop isn't in nixpkgs for Darwin, usually. 'colima' + 'docker-client' is the nix way.
    docker-client
  ];
}