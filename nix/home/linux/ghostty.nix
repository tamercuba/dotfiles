{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    pkgs.ghostty
  ];

  home.file.".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "/home/tamer/projects/dotfiles/terminal/.config/ghostty";
}
