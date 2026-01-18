{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf pkgs.stdenv.isDarwin (mkMerge [
    {
      # Common Darwin Settings
      system.defaults = {
        dock.autohide = true;
        finder.AppleShowAllExtensions = true;
        NSGlobalDomain.AppleKeyboardUIMode = 3;
      };
      
      # Enable Homebrew
      homebrew.enable = true;
    }
    (mkIf config.ivan-config-options.apps.qbittorrent.enable {
      homebrew.casks = [ "qbittorrent" ];
    })
    (mkIf config.ivan-config-options.apps.discord.enable {
      homebrew.casks = [ "discord" ];
    })
    (mkIf config.ivan-config-options.apps.vlc.enable {
      homebrew.casks = [ "vlc" ];
    })
    (mkIf config.ivan-config-options.apps.bitwarden.enable {
      homebrew.casks = [ "bitwarden" ];
    })
  ]);
}