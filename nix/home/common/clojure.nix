{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.clojure
    pkgs.leiningen
    pkgs.babashka
    pkgs.jdk
    pkgs.clojure-lsp
    pkgs.clj-kondo
  ];

  home.file.".config/clojure/deps.edn" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/tamer/projects/dotfiles/terminal/.config/clojure/deps.edn";
  };

  home.file.".config/clojure-lsp/config.edn" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/tamer/projects/dotfiles/terminal/.config/clojure-lsp/config.edn";
  };
}
