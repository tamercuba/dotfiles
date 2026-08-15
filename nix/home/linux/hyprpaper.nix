{...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        {
          monitor = "";
          path = "~/walls/default.png";
          fit_mode = "fill";
        }
      ];
    };
  };
}
