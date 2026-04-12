{config, ...}: {
  home = {
    sessionVariables = {
      PROJECTS = "/mnt/storage/projects/";
    };

    file.".ssh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/.ssh";
    };

    file."walls" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/walls";
    };

    file."drive" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/drive";
    };

    file."facul" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/facul";
    };

    file.".config/direnv/direnv.toml".text = ''
      [whitelist]
      prefix = [
        "/home/tamer/projects",
        "/home/tamer/facul",
        "/mnt/storage/projects",
        "/mnt/storage/facul"
      ]
    '';

    file.".local/bin/toggle-audio-sink-clj" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/wayland/.local/bin/toggle-audio-sink-clj";
    };

    file.".local/bin/tmux_attach_clj" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/terminal/.local/bin/tmux_attach_clj";
    };

    file.".local/bin/bb-nrepl" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/projects/dotfiles/terminal/.local/bin/bb-nrepl";
    };
  };
}
