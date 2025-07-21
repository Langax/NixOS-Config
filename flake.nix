{
  description = "NixOS Config + Home-Manager for Nyhil";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };






  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    # Top-level NixOS configuration
    nixosConfigurations = {
      malignant = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
        ];
        specialArgs = { inherit inputs; };
      };
    };

    # Home-Manager configuration for your 
    # (Optional) default package & devShell if you want them
    # defaultPackage.x86_64-linux = nixpkgs.hello;
    # devShell.x86_64-linux     = nixpkgs.mkShell { buildInputs = [ nixpkgs.git ]; };
  };
}
