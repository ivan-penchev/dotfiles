{ config, pkgs, lib, ... }:

with lib;

{
  config = {
    time.timeZone = config.ivan-config-options.system.timezone;

    # Allow unfree packages globally
    nixpkgs.config.allowUnfree = true;

    # Nix configuration
    nix = {
      settings = {
        # Enable flakes
        experimental-features = [ "nix-command" "flakes" ];
        # Optimise storage by hardlinking identical files
        auto-optimise-store = true;
        # Allow the user to manage nix
        trusted-users = [ "root" config.ivan-config-options.user.name ];
      };

      # Garbage Collection
      # Automatically remove old build dependencies and unused packages
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      } // (if pkgs.stdenv.isDarwin then {
        # macOS specific interval
        interval = {
          Hour = 1;
          Minute = 0;
          Weekday = 7;
        };
      } else {
        # Linux (NixOS) specific interval
        dates = "weekly";
      });
    };

    # Secret definitions at common level
    sops.secrets.gemini_api_key = { 
      owner = config.ivan-config-options.user.name;
    };
  };
}