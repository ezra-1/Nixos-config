{ lib, inputs, pkgs, ... }:

{
  # Home-Manager context only — do NOT put services.* or environment.* here.
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;
    immutableByDefault = true;

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
      wallpaper = ../../themes/wallpapers/mocha-mauve.webp;
    };

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

    input = {
      keyboard = {
        numlockOnStartup = "on";
        repeatDelay = 275;
        repeatRate = 35;
      };

      # DO NOT try to read /proc at build time.
      # If you really need mouse IDs, hard-code them here or omit this block.
      # mice = [{
      #   acceleration = 1.0;
      #   accelerationProfile = "none";
      #   name = "Logitech USB Optical Mouse";
      #   vendorId = "046d";
      #   productId = "c077";
      # }];
    };

    panels = [{
      screen = "all";
      height = 36;
      widgets = [
        "org.kde.plasma.pager"
        "org.kde.plasma.panelspacer"
        {
          name = "org.kde.plasma.kickoff";
          config.General.icon = "nix-snowflake";
        }
        {
          iconTasks.launchers = [
            "applications:kitty.desktop"
            "applications:obsidian.desktop"
            "applications:org.kde.dolphin.desktop"
          ];
        }
        "org.kde.plasma.panelspacer"
        "org.kde.plasma.systemtray"
        "org.kde.plasma.digitalclock"
        "org.kde.plasma.showdesktop"
      ];
    }];

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
        autoSuspend = { action = "sleep"; idleTimeout = 600; };
        turnOffDisplay.idleTimeout = 360;
        dimDisplay = { enable = true; idleTimeout = 120; };
      };
      batteryLevels = { criticalLevel = 5; criticalAction = "shutDown"; };
    };

    kscreenlocker = {
      autoLock = true;
      timeout = 5;
      passwordRequired = true;
      passwordRequiredDelay = 0;
      lockOnResume = true;
    };

    session = {
      general.askForConfirmationOnLogout = false;
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };

    configFile."baloofilerc"."Basic Settings"."Indexing-Enabled" = false;

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

