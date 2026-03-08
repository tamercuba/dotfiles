{...}: {
  services.mako = {
    enable = true;
    font = "JetBrains Mono 11";
    width = 380;
    height = 130;
    padding = "14,18";
    margin = "12";
    anchor = "top-right";
    layer = "overlay";
    borderSize = 2;
    borderRadius = 12;
    borderColor = "#b7bdf8";
    backgroundColor = "#24273aee";
    textColor = "#cad3f5";
    progressColor = "over #363a4f";
    icons = true;
    maxIconSize = 48;
    iconPath = "/usr/share/icons/hicolor";
    sort = "-time";
    maxVisible = 5;
    defaultTimeout = 7000;
    format = "<b>%s</b>\\n%b";
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
