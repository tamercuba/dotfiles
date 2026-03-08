{...}: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "Tamer Cuba";
      user.email = "tamercuba@gmail.com";
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };
}
