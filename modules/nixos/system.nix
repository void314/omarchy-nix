{
  config,
  pkgs,
  ...
}: {
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Initial login experience
  services.greetd = {
    enable = true;
    settings.default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
  };

  # Install packages
  environment.systemPackages = packages.systemPackages;

  # Networking 
  services.resolved.enable = true;
  networking = {
    hostName = hostConfig.name;
    networkmanager.enable = true;
  };
  # services.samba.enable = true;
}
