{
  pkgs-unstable,
  config,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
  };

  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/wayland/.config/hypr";
}
