{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.ivan-config-options.development-packages.enable && config.ivan-config-options.development-packages.tools.go) {
    home-manager.users.${config.ivan-config-options.user.name} = {
      home.packages = with pkgs; [
        go
        gopls
        golangci-lint
        go-task
      ];
    };
  };
}