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
    userName = "Tamer Cuba";
    userEmail = "tamercuba@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.file.".config/nvim".source = ../../../terminal/.config/nvim;
  home.file.".config/kitty".source = ../../../terminal/.config/kitty;
  home.file.".config/tmux".source = ../../../terminal/.config/tmux;
}
