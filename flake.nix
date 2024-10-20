{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwm = {
      url = "github:vanishingideal/dwm/1b30a7fe30200964747f381d2cc9bf2e1a8ac6e2";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    nixos-hardware,
    home-manager,
    dwm,
    ...
  } @ inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit dwm;
      };

      #extraSpecialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
        inputs.nixos-hardware.nixosModules.common-pc-laptop
        inputs.nixos-hardware.nixosModules.common-cpu-intel
        inputs.nixos-hardware.nixosModules.common-gpu-intel
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.sharedModules = [nixvim.homeManagerModules.nixvim];
          home-manager.useUserPackages = true;
          home-manager.users.vanishingideal = import ./home.nix;
        }
      ];
    };
  };
}
