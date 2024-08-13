{
  description = "Top level NixOS Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Unstable Packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, disko, home-manager, nixpkgs-unstable, ... }@inputs: let
    inherit (self) outputs;

    systems = [
      "aarch64-linux"
    ];

    pkgs = import nixpkgs {
      system = "aarch64-linux";
    };

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in  {


    nixosConfigurations.devinnix = nixpkgs.lib.nixosSystem {
      specialArgs = {
        meta = { hostname = "devinnix"; };
      };
      system = "aarch64-linux";
      modules = [
        # Modules
        disko.nixosModules.disko
      	# System Specific
     # 	./machines/devinnix/hardware-configuration.nix
        ./machines/devinnix/disko-config.nix
        # General
        ./configuration.nix
        # Home Manager
        ({ config, pkgs, ...}: {
        })
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.devin = import ./home/home.nix;
        }
      ];
    };

    homeConfigurations.devin = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };

      modules = [
	      ./home.nix
      ];
    };
  };
}
