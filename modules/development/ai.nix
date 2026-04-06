{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.ivan-config-options.development-packages.enable && config.ivan-config-options.development-packages.tools.ai) {
    home-manager.users.${config.ivan-config-options.user.name} = {
      home.packages = with pkgs; [
        github-copilot-cli
        gemini-cli
        aichat
        mods
      ];
    };
  };
}
