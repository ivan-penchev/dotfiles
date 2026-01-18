{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf (config.wsl.enable or false) {
    wsl.defaultUser = config.ivan-config-options.user.name;
    wsl.startMenuLaunchers = true;
    
    # Ensure Windows binaries (like Code.exe) can be executed
    wsl.interop.register = true;
    systemd.services.fix-wsl-interop = {
      description = "Fix WSL Interop for Windows executables";
      after = [ "systemd-binfmt.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.bash}/bin/bash -c 'echo :WSLInterop:M::MZ::/init:PF > /proc/sys/fs/binfmt_misc/register || true'";
      };
    };
    
    networking.hostName = "NixOS";

    # Enable Nix-LD to run unpatched dynamic binaries (like VSCode Server)
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
      glib
      libgcc
    ];
  };
}