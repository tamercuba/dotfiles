{...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = {
        monitor = "";
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      input-field = {
        monitor = "";
        size = "300, 50";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.15;
        dots_center = true;
        outer_color = "rgb(cba6f7)";
        inner_color = "rgb(313244)";
        font_color = "rgb(cdd6f4)";
        fade_on_empty = true;
        placeholder_text = ''<span foreground="##cdd6f4">Senha...</span>'';
        hide_input = false;
        check_color = "rgb(f9e2af)";
        fail_color = "rgb(f38ba8)";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "rgb(f9e2af)";
        position = "0, -120";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +'%H:%M')"'';
          color = "rgb(cdd6f4)";
          font_size = 90;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:18000000] echo "$(date +'%A, %d %B')"'';
          color = "rgb(cdd6f4)";
          font_size = 24;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
