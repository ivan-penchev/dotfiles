{
  description = "Ivan's Modular NixOS/Darwin Configuration";

  inputs = {
    # Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Darwin (macOS) support
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # WSL Support
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, nixos-wsl, ... }@inputs:
    let
      # Shared configuration for all systems
      # We import the 'modules' directory which contains our custom options and logic
      sharedModules = [
        ./modules
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];

      darwinModules = [
        ./modules
        ./modules/system/darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
      
    in
    {
      # 1. WSL Configuration (NixOS)
      nixosConfigurations.NixOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = sharedModules ++ [
          inputs.nixos-wsl.nixosModules.default
          ./modules/system/wsl.nix
          ./hosts/wsl/default.nix
        ];
      };

      # 2. Macbook Air (Personal) - Darwin
      darwinConfigurations.MacbookAir = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = darwinModules ++ [
          ./hosts/air/default.nix
        ];
      };

      # 3. Macbook Pro (Work) - Darwin
      darwinConfigurations.MacbookPro = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = darwinModules ++ [
          ./hosts/pro/default.nix
        ];
      };
    };
}
