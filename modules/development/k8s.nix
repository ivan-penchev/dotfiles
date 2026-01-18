{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.ivan-config-options.development-packages.enable && config.ivan-config-options.development-packages.tools.k8s) {
    home-manager.users.${config.ivan-config-options.user.name} = {
      home.packages = with pkgs; [
        kubectl
        kubernetes-helm
        kustomize
        k9s
        kind
        kubectx
        oras
        skopeo
        argocd
        fluxcd
        cilium-cli
        crossplane-cli
      ];
    };
  };
}
