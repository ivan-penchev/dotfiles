{ config, pkgs, lib, ... }:

{
  imports = [
    ./options.nix
    ./system/common.nix
    ./apps
    ./development
    ./utils
    ./shell/zsh.nix
    ./shell/git.nix
  ];
}