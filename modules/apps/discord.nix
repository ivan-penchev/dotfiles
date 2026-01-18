{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.ivan-config-options.apps.discord.enable {
    environment.systemPackages = [ pkgs.discord ];
  };
}
