{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.ivan-config-options.apps.vlc.enable {
    environment.systemPackages = [ 
      (if pkgs.stdenv.isDarwin then pkgs.vlc-bin else pkgs.vlc)
    ];
  };
}
