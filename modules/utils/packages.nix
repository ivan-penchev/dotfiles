{ config, pkgs, lib, ... }:
{
  config = lib.mkIf config.ivan-config-options.utils.enable {
    # System Wide Packages
    environment.systemPackages = with pkgs; [
      wget
      curl
      git
      unzip
      tree
    ];

    # User Packages
    home-manager.users.${config.ivan-config-options.user.name} = {
      # We keep stateVersion here as it's a good central place for HM config
      home.stateVersion = "25.11";
      
      home.packages = with pkgs; [
        tldr
        fd
      ];
    };
  };
}
