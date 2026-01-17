{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.ivan-config-options.apps.vscode;
in
{
  config = mkIf cfg.enable {
    home-manager.users.${config.ivan-config-options.user.name} = {
      programs.vscode = {
        enable = true;
        # Extensions can be added here
      };
    };
  };
}