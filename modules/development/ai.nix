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

      # Simplified aichat config - it will use the GEMINI_API_KEY env var
      # which we will export in the ZSH module.
      xdg.configFile."aichat/config.yaml".text = ''
        model: gemini:gemini-1.5-pro
        clients:
          - type: gemini
      '';
    };
  };
}