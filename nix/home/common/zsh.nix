{...}: {
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "bira";
      plugins = ["git" "fzf" "extract"];
    };

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;

    history = {
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    sessionVariables = {
      DISABLE_MAGIC_FUNCTIONS = "true";
      ENABLE_CORRECTION = "true";
      COMPLETION_WAITING_DOTS = "true";
      LESS_TERMCAP_md = "$(tput bold 2>/dev/null; tput setaf 2 2>/dev/null)";
      LESS_TERMCAP_me = "$(tput sgr0 2>/dev/null)";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionPath = ["$HOME/.local/bin"];
}
