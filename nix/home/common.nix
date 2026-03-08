{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.neovim
    pkgs.kitty
    pkgs.tmux
    pkgs.babashka
    pkgs.git
    pkgs.stow # Remove later
    pkgs.spotify
  ]
}
