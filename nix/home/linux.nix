{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./linux/cliphist.nix
    ./linux/gdrive.nix
    ./linux/fuzzel.nix
    ./linux/hyprland.nix
    ./linux/hyprlock.nix
    ./linux/hyprpaper.nix
    ./linux/mako.nix
    ./linux/screenshot.nix
    ./linux/waybar.nix
  ];

  home.packages = [
    pkgs.kdePackages.dolphin
    pkgs.dbeaver-bin
    pkgs.pwvucontrol
    pkgs.chromium

    pkgs.brightnessctl
    pkgs.playerctl
    pkgs.spotify

    pkgs.kind
    pkgs.kubectl
  ];

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.11";

  home.file.".XCompose".text = ''
    include "%L"
    <dead_acute> <c> : "ç" ccedilla
    <dead_acute> <C> : "Ç" Ccedilla
  '';

  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 35;
    gtk.enable = true;
    hyprcursor.enable = true;
  };
}
