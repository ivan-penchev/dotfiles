{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.ivan-config-options.apps.qbittorrent.enable {
    environment.systemPackages = [ pkgs.qbittorrent ];
  };
}