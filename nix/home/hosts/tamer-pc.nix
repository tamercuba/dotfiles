{config, ...}: {
  programs.zsh.shellAliases = {
    rebuild-nixos = "sudo nixos-rebuild switch --flake ~/projects/dotfiles#tamer-pc";
  };

  home = {
    sessionVariables = {
      PROJECTS = "/mnt/storage/projects/";
    };

    file.".ssh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/.ssh";
    };
  };
}
