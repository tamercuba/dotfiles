{
  pkgs-unstable,
  config,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    settings = {
      env = [
        "XDG_DATA_DIRS,${config.home.homeDirectory}/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
      ];
    };
    extraConfig = ''
      source = /home/tamer/projects/dotfiles/wayland/.config/hypr/hyprland.conf
    '';
  };
}
