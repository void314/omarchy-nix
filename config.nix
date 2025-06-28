lib: {
  omarchyOptions = {
    full_name = lib.mkOption {
      type = lib.types.str;
      description = "Main user's full name";
    };
    email_address = lib.mkOption {
      type = lib.types.str;
      description = "Main user's email address";
    };
    theme = lib.mkOption {
      type = lib.types.enum ["tokyo-night" "kanagawa" "everforest" "catppuccin"];
      default = "tokyo-night";
      description = "Theme to use for Omarchy configuration";
    };
    primary_font = lib.mkOption {
      type = lib.types.str;
      default = "Liberation Sans 11";
    };
    vscode_settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };

    hyprland_assignments = lib.mkOption {
      type = lib.types.attrs;
      description = "A list of Hyprland assignments to set up window rules.";
      default = {
        "$terminal" = "alacritty";
        "$fileManager" = "nautilus --new-window";
        "$browser" = "chromium --new-window --ozone-platform=wayland";
        "$music" = "spotify";
        "$passwordManager" = "1password";
        "$messenger" = "signal-desktop";
        "$webapp" = "$browser --app";
      };
    };
    quick_app_bindings = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "A list of single keystroke key bindings to launch common apps.";
      default = [
        "SUPER, A, exec, $webapp=https://chatgpt.com"
        "SUPER SHIFT, A, exec, $webapp=https://grok.com"
        "SUPER, C, exec, $webapp=https://app.hey.com/calendar/weeks/"
        "SUPER, E, exec, $webapp=https://app.hey.com"
        "SUPER, Y, exec, $webapp=https://youtube.com/"
        "SUPER SHIFT, G, exec, $webapp=https://web.whatsapp.com/"
        "SUPER, X, exec, $webapp=https://x.com/"
        "SUPER SHIFT, X, exec, $webapp=https://x.com/compose/post"

        "SUPER, return, exec, $terminal"
        "SUPER, F, exec, $fileManager"
        "SUPER, B, exec, $browser"
        "SUPER, M, exec, $music"
        "SUPER, N, exec, $terminal -e nvim"
        "SUPER, T, exec, $terminal -e btop"
        "SUPER, D, exec, $terminal -e lazydocker"
        "SUPER, G, exec, $messenger"
        "SUPER, O, exec, obsidian -disable-gpu"
        "SUPER, slash, exec, $passwordManager"
      ];
    };
  };
}
