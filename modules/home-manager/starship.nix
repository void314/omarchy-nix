{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.omarchy;
  palette = config.colorScheme.palette;
in
{
  programs.starship = {
    enable = true;
    
    # Enable starship for both fish and zsh
    enableFishIntegration = true;
    enableZshIntegration = true;
    
    settings = {
      # General configuration
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        "$line_break"
        "$python"
        "$nodejs"
        "$rust"
        "$golang"
        "$docker_context"
        "$nix_shell"
        "$character"
      ];
      
      # Right side format
      right_format = lib.concatStrings [
        "$time"
      ];
      
      # Add newline between shell prompts
      add_newline = false;
      
      # Character configuration
      character = {
        success_symbol = "[❯](bold #${palette.base0B})";
        error_symbol = "[❯](bold #${palette.base08})";
        vimcmd_symbol = "[❮](bold #${palette.base0A})";
      };
      
      # Directory configuration
      directory = {
        style = "bold #${palette.base0D}";
        format = "[$path]($style)[$read_only]($read_only_style) ";
        truncation_length = 3;
        truncation_symbol = "…/";
        read_only = " 󰌾";
        read_only_style = "#${palette.base08}";
        
        substitutions = {
          "Documents" = "📑 ";
          "Документы" = "📑 ";
          "Downloads" = "⬇️ ";
          "Загрузки" = "⬇️ ";
          "Music" = "🎧 ";
          "Музыка" = "🎧 ";
          "Pictures" = "🖼️ ";
          "Изображения" = "🖼️ ";
          "Videos" = "🎬 ";
          "Видео" = "🎬 ";
          "Desktop" = "🏠 ";
          "'Рабочий стол'" = "🏠 ";
          "Projects" = "🧩 ";
          "Шаблоны" = "🧩 ";
          "Code" = "🚀 ";
          "Код" = "🚀 ";
          ".config" = "🛠️ ";
          "Общедоступные" = "🗺️ ";
          "Public" = "🗺️ ";
        };
      };
      
      # Git branch
      git_branch = {
        symbol = " ";
        style = "#${palette.base0E}";
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };
      
      # Git status
      git_status = {
        style = "#${palette.base08}";
        format = "([$all_status$ahead_behind]($style))";
        conflicted = "=";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        up_to_date = "";
        untracked = "?\${count}";
        stashed = "$\${count}";
        modified = "!\${count}";
        staged = "+\${count}";
        renamed = "»\${count}";
        deleted = "✘\${count}";
      };
      
      # Command duration
      cmd_duration = {
        min_time = 2000;
        style = "#${palette.base0A}";
        format = "[$duration]($style) ";
      };
      
      # Time
      time = {
        disabled = false;
        style = "#${palette.base03}";
        format = "[$time]($style)";
        time_format = "%H:%M";
      };
      
      # Username
      username = {
        style_user = "#${palette.base0C}";
        style_root = "bold #${palette.base08}";
        format = "[$user]($style)";
        disabled = false;
        show_always = false;
      };
      
      # Hostname
      hostname = {
        ssh_only = true;
        style = "#${palette.base0C}";
        format = "@[$hostname]($style) ";
      };
      
      # Programming languages
      python = {
        symbol = " ";
        style = "#${palette.base0A}";
        format = "[$symbol($version)]($style) ";
        detect_extensions = ["py"];
        detect_files = [".python-version" "Pipfile" "requirements.txt" "pyproject.toml" "tox.ini"];
      };
      
      nodejs = {
        symbol = " ";
        style = "#${palette.base0B}";
        format = "[$symbol($version)]($style) ";
        detect_files = ["package.json" ".node-version" ".nvmrc"];
      };
      
      rust = {
        symbol = " ";
        style = "#${palette.base08}";
        format = "[$symbol($version)]($style) ";
        detect_files = ["Cargo.toml"];
      };
      
      golang = {
        symbol = " ";
        style = "#${palette.base0D}";
        format = "[$symbol($version)]($style) ";
        detect_files = ["go.mod" "go.sum"];
      };
      
      # Docker
      docker_context = {
        symbol = " ";
        style = "#${palette.base0D}";
        format = "[$symbol$context]($style) ";
        only_with_files = true;
        detect_files = ["docker-compose.yml" "docker-compose.yaml" "Dockerfile"];
      };
      
      # Nix shell
      nix_shell = {
        symbol = " ";
        style = "#${palette.base0E}";
        format = "[$symbol$state( \\($name\\))]($style) ";
        impure_msg = "[impure shell](bold #${palette.base08})";
        pure_msg = "[pure shell](bold #${palette.base0B})";
        unknown_msg = "[unknown shell](bold #${palette.base0A})";
      };
      
      # Package version
      package = {
        symbol = "🔨 ";
        style = "#${palette.base0C}";
        format = "[$symbol$version]($style) ";
        disabled = false;
      };
      
      # Memory usage
      memory_usage = {
        disabled = true;
        threshold = 70;
        style = "bold #${palette.base08}";
        format = "[$symbol\${ram}]($style) ";
      };
      
      # Battery
      battery = {
        full_symbol = " ";
        charging_symbol = " ";
        discharging_symbol = " ";
        unknown_symbol = " ";
        empty_symbol = " ";
        
        display = [
          {
            threshold = 10;
            style = "bold #${palette.base08}";
          }
          {
            threshold = 30;
            style = "bold #${palette.base0A}";
          }
        ];
      };
      
      # Status
      status = {
        style = "#${palette.base08}";
        symbol = "✖";
        success_symbol = "";
        not_executable_symbol = "🚫";
        not_found_symbol = "🔍";
        sigint_symbol = "🧱";
        signal_symbol = "⚡";
        format = "[$symbol$status]($style) ";
        map_symbol = true;
        disabled = false;
      };
    };
  };
}
