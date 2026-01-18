{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.ivan-config-options.development-packages.enable && config.ivan-config-options.development-packages.tools.dev) {
    home-manager.users.${config.ivan-config-options.user.name} = {
      home.packages = with pkgs; [
        nodejs
        jq
        yq
        httpie
      ];
    };
  };
}
