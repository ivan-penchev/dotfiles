{ config, pkgs, lib, ... }:

with lib;

{
  options.ivan-config-options = {
    user = {
      name = mkOption {
        type = types.str;
        default = "ivan";
        description = "Primary user name";
      };
      
      email = mkOption {
        type = types.str;
        default = "ivan.penchev@lego.com";
        description = "User email address";
      };

      home = mkOption {
        type = types.str;
        description = "Home directory";
      };
    };

    system = {
      timezone = mkOption {
        type = types.str;
        default = "Europe/Copenhagen";
        description = "System timezone";
      };
    };

    apps = {
      vscode = {
        enable = mkEnableOption "Visual Studio Code";
      };
    };

    shell = {
      zsh = {
        enable = mkEnableOption "Zsh Configuration";
      };
      git = {
        enable = mkEnableOption "Git Configuration";
      };
    };

    utils = {
      enable = mkEnableOption "Utility packages";
    };

    development-packages = {
      enable = mkEnableOption "shared development packages";
      tools = {
        go = mkEnableOption "Go development";
        python = mkEnableOption "Python development";
        rust = mkEnableOption "Rust development";
        k8s = mkEnableOption "Kubernetes tools";
        cloud = mkEnableOption "Cloud tools";
        dev = mkEnableOption "General Dev Tools";
      };
    };
  };

  config = {
    # Set home directory based on platform if not explicitly set
    ivan-config-options.user.home = mkDefault (
      if pkgs.stdenv.isDarwin then "/Users/${config.ivan-config-options.user.name}"
      else "/home/${config.ivan-config-options.user.name}"
    );

    # Define the user in the system (Common for NixOS and Darwin)
    users.users.${config.ivan-config-options.user.name} = {
      description = "Ivan Penchev";
      home = config.ivan-config-options.user.home;
      shell = pkgs.zsh;
      # NixOS specific
      isNormalUser = mkIf pkgs.stdenv.isLinux true;
      extraGroups = mkIf pkgs.stdenv.isLinux [ "wheel" "docker" ];
    };
  };
}