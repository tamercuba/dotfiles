{...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["~/walls/default.png"];
      wallpaper = [", ~/walls/default.png"];
    };
  };
}
