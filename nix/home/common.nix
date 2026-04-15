{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./common/git.nix
    ./common/zsh.nix
    ./common/lsps.nix
    ./common/sqlite.nix
  ];

  home.packages = [
    pkgs-unstable.neovim
    pkgs.tmux
    pkgs.babashka
    pkgs.stow
    pkgs-unstable.claude-code
    pkgs.btop
    pkgs.gnumake
    pkgs.ripgrep
    pkgs.unzip

    pkgs.nodejs
    pkgs.neofetch
    pkgs.go
    pkgs.rustc
    pkgs.cargo
    pkgs.jdk
    pkgs.clojure
    pkgs.leiningen

    pkgs.python3
    pkgs.uv
    pkgs.poppler-utils
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/terminal/.config/nvim";
  home.file.".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/terminal/.config/tmux";
}
