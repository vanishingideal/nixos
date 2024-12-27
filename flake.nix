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
      url = "github:vanishingideal/dwm/b179742be526b03b46d1e8dafdc314731153b50c";
      flake = false;
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    nixos-hardware,
    home-manager,
    dwm,
    ghostty,
    ...
  } @ inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit dwm;
      };

      #extraSpecialArgs = { inherit inputs; };
      modules = [
        {
          environment.systemPackages = [
            ghostty.packages.x86_64-linux.default
          ];
        }
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
