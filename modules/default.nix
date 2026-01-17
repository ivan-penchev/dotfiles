{ config, pkgs, lib, ... }:

{
  imports = [
    ./options.nix
    ./system/common.nix
    ./apps/vscode.nix
    ./development/packages.nix
    ./utils/packages.nix
    ./shell/zsh.nix
    ./shell/git.nix
  ];
}