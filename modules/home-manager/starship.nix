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
      # General configuration - updated format to match style.md example
      format = lib.concatStrings [
        "[](#${palette.base0E})"
        "$os"
        "$username"
        "$character"
        "$cmd_duration"
        "[](bg:#${palette.base08} fg:#${palette.base0E})"
        "$directory"
        "[](fg:#${palette.base08} bg:#${palette.base09})"
        "$git_branch"
        "$git_state"
        "$git_status"
        "[](fg:#${palette.base09} bg:#${palette.base0D})"
        "$c"
        "$elixir"
        "$elm"
        "$golang"
        "$gradle"
        "$haskell"
        "$java"
        "$julia"
        "$nodejs"
        "$nim"
        "$rust"
        "$scala"
        "$python"
        "$nix_shell"
        "[](fg:#${palette.base0D} bg:#${palette.base0C})"
        "$docker_context"
        "[ ](fg:#${palette.base0A})"
      ];
      
      # Right side format
      right_format = lib.concatStrings [
        "$time"
        # "$sudo"
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
        style = "bold fg:#${palette.base0D} bg:#${palette.base09}";
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
        style = "bold fg:#${palette.base0E} bg:#${palette.base09}";
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };
      
      # Git status
      git_status = {
        style = "fg:#${palette.base08} bg:#${palette.base09}";
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
        style = "fg:#${palette.base0A} bg:#${palette.base09}";
        format = "[$duration]($style) ";
      };
      
      # Time
      time = {
        disabled = false;
        style = "fg:#${palette.base03} bg:#${palette.base09}";
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
        style = "fg:#${palette.base03} bg:#${palette.base09}";
        disabled = true;
      };
      
      # Username
      username = {
        style_user = "fg:#${palette.base0C} bg:#${palette.base09}";
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
        style = "fg:#${palette.base0C} bg:#${palette.base09}";
        trim_at = ".";
      };
      
      # Programming languages - updated to match style.md example
      c = {
        symbol = " ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
        disabled = false;
        detect_extensions = ["c" "h"];
        detect_files = [];
        detect_folders = [];
      };

      cpp = {
        symbol = " ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
        disabled = false;
        detect_extensions = ["cpp" "cxx" "cc" "hpp" "hxx"];
        detect_files = [];
        detect_folders = [];
      };

      elixir = {
        symbol = " ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
        disabled = false;
        detect_extensions = [];
        detect_files = ["mix.exs"];
        detect_folders = [];
      };

      elm = {
        symbol = " ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
        disabled = false;
        detect_extensions = ["elm"];
        detect_files = ["elm.json" "elm-package.json" ".elm-version"];
        detect_folders = ["elm-stuff"];
      };

      gradle = {
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
        disabled = false;
        detect_files = ["build.gradle" "build.gradle.kts"];
        detect_folders = [];
      };

      haskell = {
        symbol = " ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
        disabled = false;
        detect_extensions = ["hs" "cabal" "hs-boot"];
        detect_files = ["stack.yaml" "cabal.project"];
        detect_folders = [];
      };

      java = {
        symbol = " ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
        disabled = false;
        detect_extensions = ["java" "class" "jar" "gradle" "clj" "cljc"];
        detect_files = ["pom.xml" "build.gradle.kts" "build.sbt" ".java-version" "deps.edn" "project.clj" "build.boot"];
        detect_folders = [];
      };

      julia = {
        symbol = " ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
        disabled = false;
        detect_extensions = ["jl"];
        detect_files = ["Project.toml" "Manifest.toml"];
        detect_folders = [];
      };

      nim = {
        symbol = "󰆥 ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
        disabled = false;
        detect_extensions = ["nim" "nims" "nimble"];
        detect_files = ["nim.cfg"];
        detect_folders = [];
      };

      scala = {
        symbol = " ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
        disabled = false;
        detect_extensions = ["scala" "sbt"];
        detect_files = ["build.sbt" ".scalaenv" ".sbtenv" "build.sc"];
        detect_folders = [".metals"];
      };
      
      python = {
        symbol = " ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
        detect_extensions = ["py"];
        detect_files = [".python-version" "Pipfile" "requirements.txt" "pyproject.toml" "tox.ini"];
      };
      
      nodejs = {
        format = "[ $symbol ($version) ]($style)";
        not_capable_style = "bold red";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        symbol = " ";
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
        format = "[ $symbol ($version) ]($style)";
        version_format = "v$raw";
        symbol = " ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        disabled = false;
        detect_extensions = ["rs"];
        detect_files = ["Cargo.toml"];
        detect_folders = [];
      };
      
      golang = {
        symbol = " ";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol ($version) ]($style)";
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
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        format = "[ $symbol $context ]($style)";
        only_with_files = true;
        disabled = false;
        detect_extensions = [];
        detect_files = ["docker-compose.yml" "docker-compose.yaml" "Dockerfile"];
        detect_folders = [];
      };
      
      nix_shell = {
        disabled = false;
        impure_msg = "[impure shell](bold red)";
        pure_msg = "[pure shell](bold green)";
        unknown_msg = "[unknown shell](bold yellow)";
        format = "[ $state( \\($name\\)) ]($style)";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        heuristic = false;
      };
      
      package = {
        format = "[ $symbol $version ]($style)";
        style = "fg:#${palette.base0D} bg:#${palette.base09}";
        symbol = "📦 ";
        disabled = false;
        display_private = false;
        version_format = "v$raw";
      };
      
      memory_usage = {
        disabled = false;
        threshold = -1;
        symbol = "🐏 ";
        style = "fg:#${palette.base0D} bg:#${palette.base08}";
        format = "[ $symbol $ram( | $swap) ]($style)";
      };
      
      battery = {
        full_symbol = "🔋 ";
        charging_symbol = "⚡️ ";
        discharging_symbol = "💀 ";
        unknown_symbol = "❓ ";
        empty_symbol = "❗ ";
        disabled = false;
        format = "[ $symbol$percentage ]($style)";
        display = [
          {
            threshold = 10;
            style = "bg:#${palette.base08}";
            charging_symbol = "⚡️ ";
            discharging_symbol = "💀 ";
          }
          {
            threshold = 30;
            style = "bg:#${palette.base09}";
            charging_symbol = "⚡️ ";
            discharging_symbol = "💦 ";
          }
          {
            threshold = 50;
            style = "bg:#${palette.base0A}";
            charging_symbol = "⚡️ ";
          }
          {
            threshold = 80;
            style = "bg:#${palette.base0B}";
            charging_symbol = "⚡️ ";
          }
          {
            threshold = 100;
            style = "bg:#${palette.base0B}";
            charging_symbol = "⚡️ ";
          }
        ];
      };
      
      status = {
        style = "fg:#${palette.base0D} bg:#${palette.base08}";
        symbol = "🔴 ";
        success_symbol = "🟢 SUCCESS";
        not_executable_symbol = "🚫 ";
        not_found_symbol = "🔍 ";
        sigint_symbol = "🧱 ";
        signal_symbol = "⚡ ";
        format = "[ $symbol$common_meaning$signal_name$maybe_int ]($style)";
        map_symbol = true;
        disabled = false;
        pipestatus = false;
        pipestatus_separator = "|";
        pipestatus_format = "\\[$pipestatus\\] => [$symbol$common_meaning$signal_name$maybe_int]($style)";
      };
      
      sudo = {
        style = "fg:#${palette.base0D} bg:#${palette.base08}";
        symbol = "🧙 ";
        format = "[ $symbol ]($style)";
        disabled = false;
        allow_windows = false;
      };
    };
  };
}
