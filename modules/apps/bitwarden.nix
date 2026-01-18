{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.ivan-config-options.apps.bitwarden.enable {
    environment.systemPackages = [ pkgs.bitwarden-desktop ];
  };
}
