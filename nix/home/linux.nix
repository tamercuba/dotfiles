{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./linux/cliphist.nix
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
  ];

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.11";

  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 35;
    gtk.enable = true;
    hyprcursor.enable = true;
  };
}
