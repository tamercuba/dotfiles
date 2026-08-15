{
  pkgs-unstable,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    configType = "lua";
    extraConfig = builtins.readFile ../../../wayland/.config/hypr/hyprland.lua;
  };
}
