{ config, lib, pkgs, ... }:
let
  helmVersion = "4.1.3";
  helmPlatform =
    if pkgs.stdenv.hostPlatform.system == "x86_64-linux" then "linux-amd64"
    else if pkgs.stdenv.hostPlatform.system == "aarch64-linux" then "linux-arm64"
    else if pkgs.stdenv.hostPlatform.system == "x86_64-darwin" then "darwin-amd64"
    else if pkgs.stdenv.hostPlatform.system == "aarch64-darwin" then "darwin-arm64"
    else throw "Unsupported system for helmLatest: ${pkgs.stdenv.hostPlatform.system}";

  helmHashes = {
    "linux-amd64" = "sha256-As6XItVBI4+BRZk4uEz0ffL98Rh0k7S/sjRnVNgqRwA=";
    "linux-arm64" = "sha256-XbReAnzI3kZ37IaeXYA/x2MbC6scHrYqxgOmLSI1mkM=";
    "darwin-amd64" = "sha256-dCEy4RzAioHJf3AYDNcUroN2+MiWJHp7FK4fUYOLWgs=";
    "darwin-arm64" = "sha256-IcAv4vfifQjiSmv5MQP50rJaq28T+RgUss+ryZsQil4=";
  };

  helmLatest = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "helm";
    version = helmVersion;

    src = pkgs.fetchurl {
      url = "https://get.helm.sh/helm-v${version}-${helmPlatform}.tar.gz";
      hash = helmHashes.${helmPlatform};
    };

    dontUnpack = true;

    installPhase = ''
      tar -xzf "$src"
      install -Dm755 "${helmPlatform}/helm" "$out/bin/helm"
    '';
  };
in
{
  config = lib.mkIf (config.ivan-config-options.development-packages.enable && config.ivan-config-options.development-packages.tools.k8s) {
    home-manager.users.${config.ivan-config-options.user.name} = {
      home.packages = with pkgs; [
        kubectl
        helmLatest
        kustomize
        k9s
        kind
        kubectx
        argocd
        fluxcd
        cilium-cli
        crossplane-cli
      ];
    };
  };
}
