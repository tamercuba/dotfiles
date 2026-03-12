{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    initExtra = ''
      [[ -f "$HOME/.zshrc" ]] && source "$HOME/.zshrc"
    '';
  };

  home.packages = with pkgs; [
    oh-my-zsh
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
    fzf
  ];

  home.file.".zshrc".source =
    config.lib.file.mkOutOfStoreSymlink
    "/mnt/storage/projects/dotfiles/terminal/.zshrc";
}
