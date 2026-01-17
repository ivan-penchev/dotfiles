{ config, pkgs, lib, ... }:

with lib;

{
  config = {
    time.timeZone = config.ivan-config-options.system.timezone;

    # Allow unfree packages globally
    nixpkgs.config.allowUnfree = true;

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}