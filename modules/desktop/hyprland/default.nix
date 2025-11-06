{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  # ------------------------------------------------------
  # 🪟 Hyprland — Wayland compositor setup
  # ------------------------------------------------------

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;

    settings = {
      # --------------------------------------------------
      # 🖥️ Displays & Autostart
      # --------------------------------------------------
      monitor = "eDP-1, preferred, auto, 1";
      exec-once = [
        "waybar"
        "mako"
        "hyprpaper"
      ];

      # --------------------------------------------------
      # ⚙️ General Layout & Appearance
      # --------------------------------------------------
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 3;
        layout = "dwindle";
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 10;
          passes = 3;
        };
      };

      animations = {
        enabled = true;
        animation = "windows, 1, 7, default";
      };

      # --------------------------------------------------
      # ⌨️ Input Configuration
      # --------------------------------------------------
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };

      # --------------------------------------------------
      # ⌨️ Keybinds
      # --------------------------------------------------
      bind = [
        "SUPER, Return, exec, alacritty"
        "SUPER, Q, killactive"
        "SUPER, F, fullscreen"
        "SUPER, E, exec, thunar"
        "SUPER, Space, exec, rofi -show drun"
        "SUPER SHIFT, E, exec, wlogout"
        "SUPER, P, pseudo"
        "SUPER, R, reload"
      ];
    };
  };

  # ------------------------------------------------------
  # 🎨 Wayland Utilities
  # ------------------------------------------------------
  programs.waybar.enable = true;
  services.mako.enable = true;

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/Pictures/wallpapers/current.jpg
    wallpaper = eDP-1, ~/Pictures/wallpapers/current.jpg
  '';

  # ------------------------------------------------------
  # 🧰 Required Packages
  # ------------------------------------------------------
  home.packages = with pkgs; [
    waybar
    wlogout
    rofi-wayland
    alacritty
    hyprpaper
    hyprlock
    hypridle
    wl-clipboard
    grim
    slurp
    thunar
  ];
}

