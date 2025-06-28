{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./autostart.nix
    ./bindings.nix
    ./envs.nix
    ./looknfeel.nix
    ./windows.nix
  ];
  wayland.windowManager.hyprland.settings = {
    # Default applications
    "$terminal" = "alacritty";
    "$fileManager" = "nautilus --new-window";
    "$browser" = "chromium --new-window --ozone-platform=wayland";
    "$music" = "spotify";
    "$passwordManager" = "1password";
    "$messenger" = "signal-desktop";
    "$webapp" = "$browser --app";

    # Environment variables
    env = [
      "GDK_SCALE,2" # Change to 1 if on a 1x display

      # TODO: Flake config
      # Uncomment if running NVIDIA GPU:
      # "NVD_BACKEND,direct"
      # "LIBVA_DRIVER_NAME,nvidia"
      # "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    ];
  };
}
