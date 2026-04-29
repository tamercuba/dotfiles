{config, ...}: {
  home = {
    sessionVariables = {
      PROJECTS = "/home/tamer/projects/";
    };

    file."drive" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/drive";
    };

    file.".config/direnv/direnv.toml".text = ''
      [whitelist]
      prefix = [
        "/home/tamer/projects",
        "/home/tamer/facul"
      ]
    '';

    file.".local/bin/toggle-audio-sink-clj" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tamer/projects/dotfiles/wayland/.local/bin/toggle-audio-sink-clj";
    };

    file.".local/bin/corne-battery" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tamer/projects/dotfiles/wayland/.local/bin/corne-battery";
    };

    file.".local/bin/tmux_attach_clj" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tamer/projects/dotfiles/terminal/.local/bin/tmux_attach_clj";
    };

    file.".local/bin/bb-nrepl" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tamer/projects/dotfiles/terminal/.local/bin/bb-nrepl";
    };
  };
}
