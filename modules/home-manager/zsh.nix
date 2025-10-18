{ config, ... }:
{
  programs.zsh = {
    enable = config.omarchy.shell == "zsh";
    autosuggestion.enable = true;
    zplug = {
      enable = true;
      plugins = [
        {
          name = "plugins/git";
          tags = [ "from:oh-my-zsh" ];
        }
        {
          name = "fdellwing/zsh-bat";
          tags = [ "as:command" ];
        }
      ];
    };
  };
}
