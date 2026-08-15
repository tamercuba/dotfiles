{
  pkgs-unstable,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    configType = "lua";
    extraConfig = "require(\"/home/tamer/projects/dotfiles/wayland/.config/hypr/hyprland.lua\")";
  };
}
