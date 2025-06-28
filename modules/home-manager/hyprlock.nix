inputs: {
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.omarchy;
  themes = import ../themes.nix;
  theme = themes.${cfg.theme};

  backgroundRgb = "rgb(${inputs.nix-colors.lib.conversions.hexToRGBString ", " (builtins.substring 1 6 theme.background)})";
  surfaceRgb = "rgb(${inputs.nix-colors.lib.conversions.hexToRGBString ", " (builtins.substring 1 6 theme.surface)})";
  foregroundRgb = "rgb(${inputs.nix-colors.lib.conversions.hexToRGBString ", " (builtins.substring 1 6 theme.foreground)})";
  foregroundMutedRgb = "rgb(${inputs.nix-colors.lib.conversions.hexToRGBString ", " (builtins.substring 1 6 theme.foreground_muted)})";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        no_fade_in = false;
      };
      auth = {
        fingerprint.enabled = true;
      };
      background = {
        monitor = "";
        color = backgroundRgb;
      };

      input-field = {
        monitor = "";
        size = "600, 100";
        position = "0, 0";
        halign = "center";
        valign = "center";

        # inner_color = "rgba(45,53,59,0.8)"; # #2d353b with opacity
        inner_color = surfaceRgb;
        outer_color = foregroundRgb; # #d3c6aa
        outline_thickness = 4;

        font_family = "CaskaydiaMono Nerd Font";
        font_size = 32;
        font_color = foregroundRgb;

        placeholder_color = foregroundMutedRgb;
        placeholder_text = "Enter Password";
        check_color = "rgba(131, 192, 146, 1.0)";
        fail_text = "Wrong";

        rounding = 0;
        shadow_passes = 0;
        fade_on_empty = false;
      };
    };
  };
}
