inputs: {
  config,
  pkgs,
  ...
}: let
  packages = import ../packages.nix {inherit pkgs;};
in {
  imports = [
    (import ./hyprland.nix inputs)
    (import ./system.nix)
    (import ./1password.nix)
    (import ./podman.nix)
  ];

  environment.systemPackages = packages.systemPackages;
}
