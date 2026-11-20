{
  description = "Cookshop POS Cofiguration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # home-manager.follows = "home-manager";
      };
    };
    waydroid_script.url = "github:casualsnek/waydroid_script";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.pos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix ];
    };
  };
}
