{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    pkgs.clojure-lsp
    pkgs.lua-language-server
    pkgs.rust-analyzer
    pkgs.gopls
    pkgs.ruff
    pkgs.clj-kondo
    pkgs.stylua
    pkgs.prettierd
    pkgs.nodePackages.prettier
    pkgs.nixd
    pkgs.alejandra
    pkgs.gotools
    pkgs.golines
    pkgs.gofumpt
    pkgs.rustfmt
    pkgs.sql-formatter
    pkgs.yaml-language-server
    pkgs.tree-sitter
  ];

  home.file.".config/clojure-lsp/config.edn" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/tamer/projects/dotfiles/terminal/.config/clojure-lsp/config.edn";
  };
}
