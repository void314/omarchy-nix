{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
    pamixer
    playerctl
    bibata-cursors
    gnome-themes-extra
  ];

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.greetd = {
    enable = true;
    settings.default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
  };

  networking.networkmanager.enable = true;
}
