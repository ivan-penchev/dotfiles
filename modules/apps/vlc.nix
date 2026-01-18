{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.ivan-config-options.apps.vlc.enable {
    environment.systemPackages = lib.optional pkgs.stdenv.isLinux pkgs.vlc;
  };
}
