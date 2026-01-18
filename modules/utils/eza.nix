{ config, lib, ... }:
{
  config = lib.mkIf config.ivan-config-options.utils.enable {
    home-manager.users.${config.ivan-config-options.user.name} = {
      programs.eza = {
        enable = true;
        enableZshIntegration = true;
        icons = "auto";
        git = true;
      };
    };
  };
}
