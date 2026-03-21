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
  ];

  home.packages = [
    pkgs.neovim
    pkgs.kitty
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

  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/terminal/.config/nvim";
  home.file.".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/terminal/.config/kitty";
  home.file.".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/terminal/.config/tmux";
}
