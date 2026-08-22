{
  description = "tamer nix config — multi-host";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gruvbox-gtk-theme = {
      url = "github:Fausto-Korpsvart/Gruvbox-GTK-Theme";
      flake = false;
    };
    open-design = {
      url = "github:nexu-io/open-design";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    gruvbox-gtk-theme,
    open-design,
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
      specialArgs = {inherit pkgs-unstable gruvbox-gtk-theme open-design;};
      modules = [
        ./nix/hosts/tamer-pc/configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };

  };
}
