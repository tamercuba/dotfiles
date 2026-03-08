{
  config,
  pkgs,
  ...
}: {
  imports = [./common.nix];

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.11";
}
