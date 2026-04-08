{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    pkgs.ghostty
  ];

  home.file.".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/terminal/.config/ghostty";
}
