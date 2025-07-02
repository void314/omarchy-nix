{
  config,
  pkgs,
  ...
}: let
  cfg = config.omarchy;
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
        primary.background = "#${config.colorScheme.palette.base00}";
        primary.foreground = "#${config.colorScheme.palette.base05}";

        normal.black = "#${config.colorScheme.palette.base00}"; 
        normal.red = "#${config.colorScheme.palette.base08}"; 
        normal.green = "#${config.colorScheme.palette.base0B}"; 
        normal.yellow = "#${config.colorScheme.palette.base0A}"; 
        normal.blue = "#${config.colorScheme.palette.base0D}"; 
        normal.magenta = "#${config.colorScheme.palette.base0E}"; 
        normal.cyan = "#${config.colorScheme.palette.base0C}"; 
        normal.white = "#${config.colorScheme.palette.base05}"; 

        bright.black = "#${config.colorScheme.palette.base03}"; 
        bright.red = "#${config.colorScheme.palette.base09}"; 
        bright.green = "#${config.colorScheme.palette.base01}"; 
        bright.yellow = "#${config.colorScheme.palette.base02}"; 
        bright.blue = "#${config.colorScheme.palette.base04}"; 
        bright.magenta = "#${config.colorScheme.palette.base06}"; 
        bright.cyan = "#${config.colorScheme.palette.base0F}"; 
        bright.white = "#${config.colorScheme.palette.base07}"; 
      };
    };
  };
}
