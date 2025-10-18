{ config, ... }:
{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = config.omarchy.shell == "zsh";
    enableFishIntegration = config.omarchy.shell == "fish";
  };
}
