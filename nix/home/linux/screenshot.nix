{pkgs, ...}: {
  home.packages = [
    pkgs.grim
    pkgs.slurp
    pkgs.swappy
    pkgs.playerctl
    pkgs.brightnessctl
  ];

  xdg.configFile."swappy/config".text = ''
    [Default]
    save_dir=$HOME/Pictures/screenshots
    save_filename_format=%y-%m-%d-%Hh%Mm%Ss.png
  '';
}
