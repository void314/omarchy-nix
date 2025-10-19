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
    
    # Enable starship integration based on selected shell
    enableFishIntegration = config.omarchy.shell == "fish";
    enableZshIntegration = config.omarchy.shell == "zsh";
    
    settings = {
      # General configuration
      format = lib.concatStrings [
        "[](#9A348E)"
        "$os"
        "$username"
        "$character"
        "$cmd_duration"
        "[](bg:#DA627D fg:#9A348E)"
        "$directory"
        "[](fg:#DA627D bg:#FCA17D)"
        "$git_branch"
        "$git_state"
        "$git_status"
        "[](fg:#FCA17D bg:#86BBD8)"
        "$golang"
        "$python"
        "$nodejs"
        "$rust"
        "$nix_shell"
        "[](fg:#86BBD8 bg:#06969A)"
        "$docker_context"
        "[ ](fg:#33658A)"
      ];
      
      # Right side format
      right_format = lib.concatStrings [
        "$time"
        "$sudo"
      ];
      
      # Add newline between shell prompts
      add_newline = false;

      # Command timeout
      command_timeout = 500;

      # Continuation prompt
      continuation_prompt = "[∙](bright-black) ";
      
      # Scan timeout
      scan_timeout = 30;
      
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
          "Documents" = "󰈙 ";
          "Документы" = "󰈙 ";
          "Downloads" = " ";
          "Загрузки" = " ";
          "Music" = " ";
          "Музыка" = " ";
          "Pictures" = " ";
          "Изображения" = " ";
          "Videos" = "󰕧 ";
          "Видео" = "󰕧 ";
          "Desktop" = "󰟀 ";
          "Рабочий стол" = "󰟀 ";
          "Projects" = "󰆧 ";
          "Шаблоны" = "󰆧 ";
          "Code" = "󰙯 ";
          "Код" = "󰙯 ";
          ".config" = "󰒓 ";
          "Общедоступные" = "󰖟 ";
          "Public" = "󰖟 ";
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
        up_to_date = "✓";
        untracked = "?\${count}";
        stashed = "$\${count}";
        modified = "󰈙\${count}";
        staged = "+\${count}";
        renamed = "󰛿\${count}";
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
        use_12hr = false;
        utc_time_offset = "local";
        # time_format = "%R"; # Hour:Minute Format;
        time_format = "%T"; # Hour:Minute:Seconds Format;
        time_range = "-";
      };

      # An alternative to the username module which displays a symbol that
      # represents the current operating system
      os = {
        style = "#${palette.base03}";
        disabled = true;
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
        disabled = false;
        format = "[$ssh_symbol](blue dimmed bold)[$hostname]($style) ";
        ssh_only = false;
        style = "#${palette.base0C}";
        trim_at = ".";
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
        format = "[$symbol($version)]($style) ";
        not_capable_style = "bold red";
        style = "#${palette.base0B}";
        symbol = " ";
        version_format = "v$raw";
        disabled = false;
        detect_extensions = [
          "js"
          "mjs"
          "cjs"
          "ts"
          "mts"
          "cts"
        ];
        detect_files = [
          "package.json"
          ".node-version"
          ".nvmrc"
        ];
        detect_folders = ["node_modules"];
      };
      
      rust = {
        format = "[$symbol($version)]($style) ";
        version_format = "v$raw";
        symbol = "🦀 ";
        style = "#${palette.base08}";
        disabled = false;
        detect_extensions = ["rs"];
        detect_files = ["Cargo.toml"];
        detect_folders = [];
      };
      
      golang = {
        symbol = " ";
        style = "#${palette.base0D}";
        format = "[$symbol($version)]($style) ";
        detect_extensions = ["go"];
        detect_files = [
          "go.mod"
          "go.sum"
          "glide.yaml"
          "Gopkg.yml"
          "Gopkg.lock"
          ".go-version"
        ];
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
        symbol = "❄️ ";
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
        format = "[$symbol$status]($style) ";
        map_symbol = true;
        not_executable_symbol = "🚫";
        not_found_symbol = "🔍";
        pipestatus = false;
        pipestatus_format = "[$pipestatus] => [$symbol$common_meaning$signal_name$maybe_int]($style)";
        pipestatus_separator = "|";
        recognize_signal_code = true;
        signal_symbol = "⚡";
        style = "#${palette.base08}";
        success_symbol = "🟢 SUCCESS";
        symbol = "🔴 ";
        disabled = true;
      };

      sudo = {
        format = "[as $symbol]($style)";
        symbol = "🧙 ";
        style = "bold blue";
        allow_windows = false;
        disabled = true;
      };
    };
  };
}
