{ lib, pkgs, ... }:

let
  inherit (lib) getExe getExe';
in {
  programs.alacritty = {
    enable = true;

    settings = {
      ## --------------------------------------------------
      ## 🧊 General
      ## --------------------------------------------------
      general.live_config_reload = true;

      ## --------------------------------------------------
      ## 🌿 Environment
      ## --------------------------------------------------
      env = {
        TERM = "alacritty";
        WINIT_X11_SCALE_FACTOR = "1.0";
      };

      ## --------------------------------------------------
      ## 🖱 Cursor
      ## --------------------------------------------------
      cursor = {
        blink_interval = 550;
        unfocused_hollow = false;
        thickness = 0.15;
        style = {
          blinking = "On";
          shape = "Block";
        };
      };

      ## --------------------------------------------------
      ## 📋 Selection
      ## --------------------------------------------------
      selection.save_to_clipboard = true;

      ## --------------------------------------------------
      ## 🪟 Window
      ## --------------------------------------------------
      window = {
        decorations = "none";
        dynamic_title = true;
        opacity = 1.0;
        dynamic_padding = true;
        resize_increments = true;
        padding = { x = 15; y = 15; };
      };

      ## --------------------------------------------------
      ## 🧭 Scrolling
      ## --------------------------------------------------
      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      ## --------------------------------------------------
      ## 🎨 Colors (Catppuccin Mocha)
      ## --------------------------------------------------
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          dim_foreground = "#7f849c";
          bright_foreground = "#cdd6f4";
        };
        cursor = {
          text = "#1e1e2e";
          cursor = "#f5e0dc";
        };
        vi_mode_cursor = {
          text = "#1e1e2e";
          cursor = "#b4befe";
        };
        search = {
          matches = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
          focused_match = {
            foreground = "#1e1e2e";
            background = "#a6e3a1";
          };
        };
        footer_bar = {
          foreground = "#1e1e2e";
          background = "#a6adc8";
        };
        hints = {
          start = {
            foreground = "#1e1e2e";
            background = "#f9e2af";
          };
          end = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
        };
        selection = {
          text = "#1e1e2e";
          background = "#f5e0dc";
        };
        normal = {
          black   = "#45475a";
          red     = "#f38ba8";
          green   = "#a6e3a1";
          yellow  = "#f9e2af";
          blue    = "#89b4fa";
          magenta = "#f5c2e7";
          cyan    = "#94e2d5";
          white   = "#bac2de";
        };
        bright = {
          black   = "#585b70";
          red     = "#f38ba8";
          green   = "#a6e3a1";
          yellow  = "#f9e2af";
          blue    = "#89b4fa";
          magenta = "#f5c2e7";
          cyan    = "#94e2d5";
          white   = "#a6adc8";
        };
        indexed_colors = [
          { index = 16; color = "#fab387"; }
          { index = 17; color = "#f5e0dc"; }
        ];
      };

      ## --------------------------------------------------
      ## 🔤 Font
      ## --------------------------------------------------
      font = {
        size = 10;
        builtin_box_drawing = true;
        normal.family = "JetBrainsMono Nerd Font";
      };

      ## --------------------------------------------------
      ## ⌨️ Keybindings
      ## --------------------------------------------------
      keyboard.bindings = [
        {
          chars = "cd $(${getExe pkgs.fd} . /mnt/work /mnt/work/dev/ /run /run/current-system ~/.local/ ~/ --max-depth 2 | fzf)\r";
          key = "F";
          mods = "Control";
        }
        {
          chars = "tmux-sessionizer\r";
          key = "T";
          mods = "Control";
        }
        {
          action = "Paste";
          key = "Y";
          mods = "Control";
        }
        {
          action = "Copy";
          key = "W";
          mods = "Alt";
        }
        {
          action = "SpawnNewInstance";
          key = "Return";
          mods = "Super|Shift";
        }
      ];
    };
  };
}

