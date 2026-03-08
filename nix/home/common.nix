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
    pkgs.stow # Remove later
    pkgs.spotify
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Tamer Cuba";
      user.email = "tamercuba@gmail.com";
      init.defaultBranch = "main";
    };
  };

  home.file.".config/nvim".source = ../../terminal/.config/nvim;
  home.file.".config/kitty".source = ../../terminal/.config/kitty;
  home.file.".config/tmux".source = ../../terminal/.config/tmux;
}
