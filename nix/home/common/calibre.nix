{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  configDir = "${config.home.homeDirectory}/.config/calibre";
  booksDir = "${config.home.homeDirectory}/books";

  globalConfig = pkgs.writeText "calibre-global.py.json" (builtins.toJSON {
    library_path = booksDir;
    output_format = "azw3";
    language = "en";
    filename_pattern = "(?P<title>.+) - (?P<author>[^_]+)";
    input_format_order = [
      "EPUB"
      "AZW3"
      "MOBI"
      "LIT"
      "PRC"
      "FB2"
      "HTML"
      "HTM"
      "XHTM"
      "SHTML"
      "XHTML"
      "ZIP"
      "DOCX"
      "ODT"
      "RTF"
      "PDF"
      "TXT"
    ];
    manage_device_metadata = "manual";
    network_timeout = 5;
    worker_process_priority = "normal";
  });

  guiPyConfig = pkgs.writeText "calibre-gui.py.json" (builtins.toJSON {
    gui_layout = "wide";
    column_map = [
      "title"
      "ondevice"
      "authors"
      "size"
      "timestamp"
      "rating"
      "publisher"
      "tags"
      "series"
      "pubdate"
    ];
    worker_limit = 6;
    confirm_delete = false;
    search_as_you_type = false;
    auto_download_cover = false;
    autolaunch_server = false;
    use_roman_numerals_for_series_number = true;
    new_version_notification = true;
  });

  guiConfig = pkgs.writeText "calibre-gui.json" (builtins.toJSON {
    color_palette = "dark";
    dark_palettes = {
      __current__ = {
        Accent = "#7abc43";
        AlternateBase = "#2d2d2d";
        Base = "#121212";
        BrightText = "#ff0000";
        "BrightText-disabled" = "#ff0000";
        Button = "#2d2d2d";
        ButtonText = "#dddddd";
        "ButtonText-disabled" = "#7f7f7f";
        Highlight = "#0b45c4";
        HighlightedText = "#dddddd";
        "HighlightedText-disabled" = "#7f7f7f";
        Link = "#6cb4ee";
        LinkVisited = "#800080";
        PlaceholderText = "#7f7f7f";
        "PlaceholderText-disabled" = "#7f7f7f";
        Text = "#dddddd";
        "Text-disabled" = "#7f7f7f";
        ToolTipBase = "#2d2d2d";
        ToolTipText = "#dddddd";
        "ToolTipText-disabled" = "#dddddd";
        Window = "#2d2d2d";
        WindowText = "#dddddd";
        "WindowText-disabled" = "#dddddd";
      };
    };
  });
in {
  home.packages = [pkgs-unstable.calibre];

  home.activation.calibreConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p "${configDir}"
    if [[ ! -f "${configDir}/global.py.json" ]]; then
      $DRY_RUN_CMD cp ${globalConfig} "${configDir}/global.py.json"
    fi
    if [[ ! -f "${configDir}/gui.py.json" ]]; then
      $DRY_RUN_CMD cp ${guiPyConfig} "${configDir}/gui.py.json"
    fi
    if [[ ! -f "${configDir}/gui.json" ]]; then
      $DRY_RUN_CMD cp ${guiConfig} "${configDir}/gui.json"
    fi
  '';
}
