{...}: {
  services.mako = {
    enable = true;
    settings = {
      font = "JetBrains Mono 11";
      width = 380;
      height = 130;
      padding = "14,18";
      margin = "12";
      anchor = "top-right";
      layer = "overlay";
      border-size = 2;
      border-radius = 12;
      border-color = "#b7bdf8";
      background-color = "#24273aee";
      text-color = "#cad3f5";
      progress-color = "over #363a4f";
      icons = true;
      max-icon-size = 48;
      icon-path = "/usr/share/icons/hicolor";
      sort = "-time";
      max-visible = 5;
      default-timeout = 7000;
      format = "<b>%s</b>\\n%b";
    };
    extraConfig = ''
      [urgency=low]
      border-color=#a5adcb
      default-timeout=5000

      [urgency=normal]
      border-color=#b7bdf8

      [urgency=high]
      border-color=#ed8796
      default-timeout=0
    '';
  };
}
