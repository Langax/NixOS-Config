{
  description = "NixOS Config + Home-Manager for Nyhil";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };


  outputs = {
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        nixConfigurations = {
          malignant = pkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./configuration.nix
              home-manager.nixosModules.home-manager
            ];
            specialArgs = { inherit self; };
          };
        };

        homeConfigurations = {
          nyhil = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home.nix ];
          };
        };
      }
    };
}
