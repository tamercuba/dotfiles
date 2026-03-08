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

    file.".local/bin/toggle-audio-sink-clj" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/wayland/.local/bin/toggle-audio-sink-clj";
    };

    file.".local/bin/tmux_attach_clj" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/terminal/.local/bin/tmux_attach_clj";
    };

    file.".local/bin/tmux_auto_attach" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/terminal/.local/bin/tmux_auto_attach";
    };

    file.".local/bin/bb-nrepl" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/terminal/.local/bin/bb-nrepl";
    };
  };
}
