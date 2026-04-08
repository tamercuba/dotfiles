{
  pkgs-unstable,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    extraConfig = ''
      source = /mnt/storage/projects/dotfiles/wayland/.config/hypr/hyprland.conf
    '';
  };
}
