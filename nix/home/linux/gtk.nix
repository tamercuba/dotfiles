{
  config,
  pkgs,
  pkgs-unstable,
  gruvbox-gtk-theme,
  lib,
  ...
}: let
  themeName = "Gruvbox-Dark-Medium";

  gruvbox-theme = pkgs.runCommand "gruvbox-gtk-theme" {
    nativeBuildInputs = [pkgs.sassc];
  } ''
    cp -r ${gruvbox-gtk-theme}/themes /tmp/themes-build
    chmod -R u+w /tmp/themes-build
    cd /tmp/themes-build
    ${pkgs.bash}/bin/bash /tmp/themes-build/install.sh --tweaks medium float -c dark -d $out/share/themes -n Gruvbox
  '';
in {
  home.packages = [pkgs.gnome-themes-extra];

  home.activation.gtkCleanup = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    $DRY_RUN_CMD rm -f "$HOME/.config/gtk-3.0/settings.ini"
    $DRY_RUN_CMD rm -f "$HOME/.config/gtk-4.0/settings.ini"
    $DRY_RUN_CMD rm -f "$HOME/.gtkrc-2.0"
  '';

  gtk = {
    enable = true;
    theme = {
      name = themeName;
      package = gruvbox-theme;
    };
    gtk4.theme = config.gtk.theme;
  };

  xdg.configFile = {
    "gtk-4.0/assets" = {
      source = "${gruvbox-theme}/share/themes/${themeName}/gtk-4.0/assets";
      force = true;
    };
    "gtk-4.0/gtk.css" = {
      source = "${gruvbox-theme}/share/themes/${themeName}/gtk-4.0/gtk.css";
      force = true;
    };
    "gtk-4.0/gtk-dark.css" = {
      source = "${gruvbox-theme}/share/themes/${themeName}/gtk-4.0/gtk-dark.css";
      force = true;
    };
  };
}
