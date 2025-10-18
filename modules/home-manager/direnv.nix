{ config, ... }:
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = config.omarchy.shell == "zsh";
    enableFishIntegration = config.omarchy.shell == "fish";
    nix-direnv.enable = true;
  };
}
