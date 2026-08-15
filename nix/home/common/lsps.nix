{pkgs, ...}: {
  home.packages = [
    pkgs.lua-language-server
    pkgs.rust-analyzer
    pkgs.gopls
    pkgs.ruff
    pkgs.stylua
    pkgs.prettierd
    pkgs.prettier
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
}
