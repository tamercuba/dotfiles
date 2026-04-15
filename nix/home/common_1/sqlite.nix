{pkgs, ...}: {
  home.packages = [pkgs.sqlite];
  programs.zsh.initContent = "export LIBSQLITE=${pkgs.sqlite.out}/lib/libsqlite3.so";
}
