{pkgs, ...}: {
  home.packages = [pkgs.sqlite];
  home.sessionVariables.LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.so";
}
