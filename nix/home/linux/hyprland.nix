{
  pkgs-unstable,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    extraConfig = ''
      source = /home/tamer/projects/dotfiles/wayland/.config/hypr/hyprland.conf
    '';
  };
}
