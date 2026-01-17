{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.ivan-config-options.development-packages.enable {
    home-manager.users.${config.ivan-config-options.user.name} = {
      home.packages =
        with pkgs;
        lib.flatten [
          # Go Tools
          (lib.optionals config.ivan-config-options.development-packages.tools.go [
            go
            gopls
          ])
          # Python Tools
          (lib.optionals config.ivan-config-options.development-packages.tools.python [
            python3
            uv
          ])
          # Rust Tools
          (lib.optionals config.ivan-config-options.development-packages.tools.rust [
            cargo
            rustc
            rustfmt
          ])
          # K8s Tools
          (lib.optionals config.ivan-config-options.development-packages.tools.k8s [
            kubectl
            kubernetes-helm
            kustomize
            k9s
          ])
          # Cloud CLI Tools
          (lib.optionals config.ivan-config-options.development-packages.tools.cloud [
            awscli2
            azure-cli
          ])
          # General Dev Tools
          (lib.optionals config.ivan-config-options.development-packages.tools.dev [
            nodejs
            jq
            yq
            httpie
          ])
        ];
    };
  };
}