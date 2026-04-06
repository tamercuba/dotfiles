{
  pkgs,
  config,
  dotfilesDir,
  ...
}: {
  programs.yazi.enable = true;

  xdg.configFile."yazi/yazi.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${dotfilesDir}/terminal/.config/yazi/yazi.toml";

  home.packages = with pkgs; [
    file
    ffmpeg
    p7zip
    jq
    poppler-utils
    fd
    ripgrep
    fzf
    zoxide
    resvg
    imagemagick
    wl-clipboard
  ];
}
