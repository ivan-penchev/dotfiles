{ config, lib, ... }:
{
  config = lib.mkIf config.ivan-config-options.utils.enable {
    home-manager.users.${config.ivan-config-options.user.name} = {
      programs.bat = {
        enable = true;
      };
    };
  };
}
