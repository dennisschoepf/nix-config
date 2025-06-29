{
  description = "dnsc-server NixOS flake";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    ip-whitelist.url = "github:Oak-Digital/nixos-ip-whitelist-firewall";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      agenix,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      nixosConfigurations.dnsc-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/dnsc-server
          agenix.nixosModules.default
        ];
      };

      nixosConfigurations.dnsc-vps-sm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/dnsc-vps-sm
          agenix.nixosModules.default
        ];
      };

      darwinConfigurations.dnsc-air = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/dnsc-air ];
      };

      darwinConfigurations.dnsc-work = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/dnsc-work ];
      };

      homeConfigurations."dnsc-deck" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./home/deck.nix ];
      };
    };
}
