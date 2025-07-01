{
  config,
  pkgs,
  ...
}: let
  cfg = config.omarchy;
  themes = import ../themes.nix;
  theme = themes.${cfg.theme};
in {
  services.mako = {
    enable = true;

    settings = {
      background-color = theme.background;
      text-color = theme.foreground;
      border-color = theme.accent;
      progress-color = theme.primary;

      width = 420;
      height = 110;
      padding = "10";
      margin = "10";
      border-size = 2;
      border-radius = 8;

      anchor = "top-right";
      layer = "overlay";

      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 5;
      sort = "-time";

      group-by = "app-name";

      actions = true;

      format = "<b>%s</b>\\n%b";
      markup = true;
    };
  };
}
