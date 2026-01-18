{ config, pkgs, lib, ... }:

# This module configures sops-nix for secrets management

{
  config = {
    # Default sops file
    sops.defaultSopsFile = ../../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    # Key to use for decryption (User's Age key)
    # Using the path defined in central options
    sops.age.keyFile = config.ivan-config-options.sops.ageKeyFile;
    
    # Enable sops for the user
    home-manager.users.${config.ivan-config-options.user.name} = {
      sops.age.keyFile = config.ivan-config-options.sops.ageKeyFile;
      sops.defaultSopsFile = ../../secrets/secrets.yaml;
    };
  };
}