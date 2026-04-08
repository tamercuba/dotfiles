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
    ./linux/kb.nix
    ./linux/yazi.nix
    ./linux/ghostty.nix
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
    pkgs.gh
    pkgs.rlwrap

    pkgs.mpv
    pkgs.swayimg

    pkgs.freecad
  ];

  xdg.desktopEntries.freecad = {
    name = "FreeCAD";
    exec = "env QT_QPA_PLATFORM=xcb freecad %F";
    icon = "freecad";
    comment = "Feature based parametric modeler";
    categories = ["Graphics" "Science" "Engineering"];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/mp4" = "mpv.desktop";
      "video/mkv" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "image/gif" = "swayimg.desktop";
    };
  };

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.11";

  home.file.".XCompose".text = ''
    include "%L"
    <dead_acute> <c> : "ç" ccedilla
    <dead_acute> <C> : "Ç" Ccedilla
  '';

  home.sessionVariables.XLOCALEDIR = "${pkgs.xorg.libX11}/share/X11/locale";

  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 35;
    gtk.enable = true;
    hyprcursor.enable = true;
  };
}
