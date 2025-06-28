{
  config,
  pkgs,
  ...
}: let
  cfg = config.omarchy;
  themes = import ../themes.nix;
  theme = themes.${cfg.theme};
in {
  programs.alacritty = {
    enable = true;
    settings = {
      # Window settings
      window = {
        padding = {
          x = 14;
          y = 14;
        };
        decorations = "none";
        opacity = 0.95;
      };

      font = {
        normal = {
          family = cfg.primary_font;
          style = "Regular";
        };
        bold = {
          family = cfg.primary_font;
          style = "Bold";
        };
        italic = {
          family = cfg.primary_font;
          style = "Italic";
        };
        bold_italic = {
          family = cfg.primary_font;
          style = "Bold Italic";
        };
        size = 11.0;
      };

      # Colors
      colors = {
        primary.background = theme.background;
        primary.foreground = theme.foreground;

        normal.black = theme.black;
        normal.red = theme.red;
        normal.green = theme.green;
        normal.yellow = theme.yellow;
        normal.blue = theme.blue;
        normal.magenta = theme.magenta;
        normal.cyan = theme.cyan;
        normal.white = theme.white;

        bright.black = theme.bright_black;
        bright.red = theme.bright_red;
        bright.green = theme.bright_green;
        bright.yellow = theme.bright_yellow;
        bright.blue = theme.bright_blue;
        bright.magenta = theme.bright_magenta;
        bright.cyan = theme.bright_cyan;
        bright.white = theme.bright_white;

        selection.background = theme.primary;
      };
    };
  };
}
