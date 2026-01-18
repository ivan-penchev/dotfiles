{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.ivan-config-options.development-packages.enable && config.ivan-config-options.development-packages.tools.cloud) {
    home-manager.users.${config.ivan-config-options.user.name} = {
      home.packages = with pkgs; [
        azure-cli
      ];
    };
  };
}
