{
  pkgs-unstable,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs-unstable.inkscape
    pkgs.imagemagick
  ];
}
