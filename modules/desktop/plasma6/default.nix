{ lib, inputs, pkgs, ... }:

{
  # Home-Manager context only — do NOT put services.* or environment.* here.
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;
    immutableByDefault = true;

    # ------------------------------------------------------
    # 🧭 General behavior
    # ------------------------------------------------------
    krunner.activateWhenTypingOnDesktop = false;

    workspace = {
      clickItemTo = "select";
      lookAndFeel = "Catppuccin-Mocha-Mauve";
      colorScheme = "CatppuccinMochaMauve";
      theme = "default";
      cursor = {
        size = 24;
        theme = "Bibata-Modern-Classic";
      };
      # If this file lives at modules/desktop/plasma6/default.nix,
      # adjust the relative path below to your actual wallpapers dir.
      wallpaper = ../../themes/wallpapers/Lofi-Study.png;
    };

    # ------------------------------------------------------
    # 🎬 Window management
    # ------------------------------------------------------
    kwin = {
      effects = {
        blur.enable = false;
        cube.enable = true;
        desktopSwitching.animation = "off";
        dimAdminMode.enable = false;
        dimInactive.enable = false;
        fallApart.enable = false;
        fps.enable = false;
        minimization.animation = "off";
        shakeCursor.enable = false;
        slideBack.enable = false;
        snapHelper.enable = false;
        translucency.enable = false;
        windowOpenClose.animation = "off";
        wobblyWindows.enable = false;
      };

      virtualDesktops = {
        number = 5;
        rows = 1;
      };
    };

    # ------------------------------------------------------
    # ⌨️ Input configuration
    # ------------------------------------------------------
    input = {
      keyboard = {
        numlockOnStartup = "on";
        repeatDelay = 275;
        repeatRate = 35;
      };

      # You can define mice here if needed
      # mice = [{
      #   name = "Logitech USB Optical Mouse";
      #   vendorId = "046d";
      #   productId = "c077";
      #   acceleration = 1.0;
      #   accelerationProfile = "none";
      # }];
    };

    # ------------------------------------------------------
    # 🧊 Panel layout
    # ------------------------------------------------------
    panels = [{
      screen = "all";
      height = 36;
      floating = true;
      widgets = [
        # 🏠 Application launcher
        {
          name = "org.kde.plasma.kickoff";
          config.General.icon = "nix-snowflake";
        }

        # 📦 Task manager launchers
        {
          iconTasks.launchers = [
            "applications:org.kde.dolphin.desktop"
            "applications:zen-beta.desktop"
            "applications:kitty.desktop"
            "applications:spotify.desktop"
            "applications:code.desktop"
          ];
        }

        # 🧱 Spacer between icons and system area
        "org.kde.plasma.panelspacer"

        # 🧭 System tray and clock
        "org.kde.plasma.systemtray"
        "org.kde.plasma.digitalclock"

        # 💨 Show desktop button
        "org.kde.plasma.showdesktop"
      ];
    }];

    # ------------------------------------------------------
    # ⚡ Power management
    # ------------------------------------------------------
    powerdevil = {
      AC = {
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "sleep";
        powerProfile = "performance";
        whenLaptopLidClosed = "sleep";
        autoSuspend.action = "nothing";
        turnOffDisplay.idleTimeout = "never";
      };

      battery = {
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "showLogoutScreen";
        powerProfile = "balanced";
        whenLaptopLidClosed = "sleep";
        autoSuspend = {
          action = "sleep";
          idleTimeout = 600;
        };
        turnOffDisplay.idleTimeout = 360;
        dimDisplay = {
          enable = true;
          idleTimeout = 120;
        };
      };

      batteryLevels = {
        criticalLevel = 5;
        criticalAction = "shutDown";
      };
    };

    # ------------------------------------------------------
    # 🔒 Screen locker
    # ------------------------------------------------------
    kscreenlocker = {
      autoLock = true;
      timeout = 5;
      passwordRequired = true;
      passwordRequiredDelay = 0;
      lockOnResume = true;
    };

    # ------------------------------------------------------
    # 💾 Session settings
    # ------------------------------------------------------
    session = {
      general.askForConfirmationOnLogout = false;
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };

    # ------------------------------------------------------
    # ⚙️ Miscellaneous configs
    # ------------------------------------------------------
    configFile."baloofilerc"."Basic Settings"."Indexing-Enabled" = false;

    # ------------------------------------------------------
    # ⌨️ Shortcuts & hotkeys
    # ------------------------------------------------------
    shortcuts."kwin"."Cube" = "Meta+C";

    hotkeys.commands = {
      "launch-kitty" = {
        name = "Launch kitty";
        key = "Meta+T";
        command = "kitty";
      };

      "launch-firefox" = {
        name = "Launch Firefox";
        key = "Meta+F";
        command = "firefox";
      };
    };
  };
}

