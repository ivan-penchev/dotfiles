{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf pkgs.stdenv.isDarwin {
    # Common Darwin Settings
    system.defaults = {
      dock.autohide = true;
      finder.AppleShowAllExtensions = true;
      NSGlobalDomain.AppleKeyboardUIMode = 3;
    };
    
    # Enable Homebrew
    homebrew.enable = true;
  };
}