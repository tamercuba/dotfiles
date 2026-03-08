{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common/git.nix
    ./common/zsh.nix
  ];

  home.packages = [
    pkgs.neovim
    pkgs.kitty
    pkgs.tmux
    pkgs.babashka
    pkgs.stow # Remove later
  ];

  home.file.".config/nvim".source = ../../terminal/.config/nvim;
  home.file.".config/kitty".source = ../../terminal/.config/kitty;
  home.file.".config/tmux".source = ../../terminal/.config/tmux;
}
