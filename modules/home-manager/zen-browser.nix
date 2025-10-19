inputs:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.omarchy.zen-browser;
in
{
  # Import Zen Browser Home Manager module
  imports = [
    inputs.zen-browser.homeModules.default
  ];

  options.omarchy.zen-browser = {
    enable = lib.mkEnableOption "Zen Browser";
    
    package = lib.mkOption {
      type = lib.types.package;
      default = inputs.zen-browser.packages.${pkgs.system}.default;
      description = "Zen Browser package to use";
    };

    setAsDefault = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Set Zen Browser as the default web browser";
    };

    policies = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Browser policies configuration";
    };

    preferences = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Browser preferences configuration";
    };

    extensions = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Extensions to install";
    };
  };

  config = lib.mkIf cfg.enable {

    programs.zen-browser = {
      enable = true;
      package = cfg.package;

      # Security and privacy policies
      policies = lib.mkMerge [
        {
          # Security settings
          DisableAppUpdate = true; # Managed by Nix
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          DisableFeedbackCommands = true;
          DisablePocket = true;
          DontCheckDefaultBrowser = !cfg.setAsDefault;
          
          # Privacy settings
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          
          # Enhanced tracking protection
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };

          # Content blocking
          Cookies = {
            Default = "reject-tracker-and-partition-foreign";
            AcceptThirdParty = "never";
            Locked = true;
          };

          # Browser preferences
          Preferences = lib.mkMerge [
            (lib.mapAttrs (_: value: {
              Value = value;
              Status = "locked";
            }) {
              # Performance and UI preferences
              "browser.tabs.warnOnClose" = false;
              "browser.tabs.warnOnCloseOtherTabs" = false;
              "browser.sessionstore.warnOnQuit" = false;
              "browser.aboutConfig.showWarning" = false;
              
              # Privacy preferences
              "privacy.donottrackheader.enabled" = true;
              "privacy.trackingprotection.enabled" = true;
              "privacy.trackingprotection.socialtracking.enabled" = true;
              "privacy.partition.network_state" = true;
              
              # Security preferences
              "security.tls.insecure_fallback_hosts" = "";
              "security.tls.unrestricted_rc4_fallback" = false;
              "security.ssl.require_safe_negotiation" = true;
              
              # Disable unnecessary features
              "extensions.pocket.enabled" = false;
              "browser.newtabpage.activity-stream.feeds.telemetry" = false;
              "browser.newtabpage.activity-stream.telemetry" = false;
              "browser.ping-centre.telemetry" = false;
              "toolkit.telemetry.enabled" = false;
              "toolkit.telemetry.unified" = false;
              "toolkit.telemetry.server" = "";
              
              # Zen-specific preferences
              "zen.tabs.vertical.right-side" = false;
              "zen.view.compact" = false;
              "zen.theme.accent-color" = "auto";
            })
            (lib.mapAttrs (_: value: {
              Value = value;
              Status = "locked";
            }) cfg.preferences)
          ];

          # Extensions configuration
          ExtensionSettings = lib.mkMerge [
            {
              # uBlock Origin
              "uBlock0@raymondhill.net" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                installation_mode = "force_installed";
              };
              
              # Privacy Badger
              "jid1-MnnxcxisBPnSXQ@jetpack" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
                installation_mode = "force_installed";
              };
            }
            (lib.mapAttrs (_: config: {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${config.id}/latest.xpi";
              installation_mode = config.mode or "force_installed";
            }) cfg.extensions)
          ];
        }
        cfg.policies
      ];
    };

    # XDG desktop integration
    xdg.desktopEntries = lib.mkIf cfg.setAsDefault {
      zen-browser = {
        name = "Zen Browser";
        genericName = "Web Browser";
        comment = "Browse the World Wide Web";
        exec = "zen %U";
        icon = "zen-browser";
        terminal = false;
        categories = [ "Network" "WebBrowser" ];
        mimeType = [
          "text/html"
          "text/xml"
          "application/xhtml+xml"
          "application/xml"
          "application/rss+xml"
          "application/rdf+xml"
          "image/gif"
          "image/jpeg"
          "image/png"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
          "x-scheme-handler/ftp"
          "x-scheme-handler/chrome"
          "video/webm"
          "application/x-xpinstall"
        ];
        actions = {
          new-window = {
            name = "New Window";
            exec = "zen --new-window %U";
          };
          new-private-window = {
            name = "New Private Window";
            exec = "zen --private-window %U";
          };
        };
      };
    };

    # Set as default browser
    xdg.mimeApps = lib.mkIf cfg.setAsDefault {
      enable = true;
      defaultApplications = {
        "text/html" = "zen-browser.desktop";
        "x-scheme-handler/http" = "zen-browser.desktop";
        "x-scheme-handler/https" = "zen-browser.desktop";
        "x-scheme-handler/about" = "zen-browser.desktop";
        "x-scheme-handler/unknown" = "zen-browser.desktop";
      };
    };
  };
}