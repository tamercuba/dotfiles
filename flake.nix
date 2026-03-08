{
  description = "tamer nix config — multi-host";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.tamer-pc = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit pkgs-unstable;};
      modules = [
        ./nix/hosts/tamer-pc/configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };

  };
}
