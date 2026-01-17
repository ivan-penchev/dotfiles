{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.ivan-config-options.shell.git;
in
{
  config = mkIf cfg.enable {
    home-manager.users.${config.ivan-config-options.user.name} = {
      programs.git = {
        enable = true;
        
        # Modern Home Manager syntax uses 'settings' for everything
        settings = {
          user = {
            name = "Ivan Penchev";
            email = config.ivan-config-options.user.email;
          };
          
          init = { defaultBranch = "main"; };
          push = { autoSetupRemote = true; };
          pull = { rebase = false; };
          
          alias = {
            s = "status";
            c = "commit";
            p = "push";
            l = "log --oneline --graph";
          };
        };
      };
    };
  };
}