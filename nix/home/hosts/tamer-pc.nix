{config, ...}: {
  home = {
    sessionVariables = {
      PROJECTS = "/mnt/storage/projects/";
    };

    file.".ssh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/.ssh";
    };
  };
}
