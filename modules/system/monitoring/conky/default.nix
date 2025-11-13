{ config, pkgs, lib, ... }:

{
  # Install Conky
  home.packages = with pkgs; [ conky ];

  # Optional: Xsession autostart (if using Plasma/X11)
  xsession.enable = true;
  xsession.windowManager.command = "conky &";

  # Systemd user service (recommended for Wayland/Hyprland)
  systemd.user.services.conky = {
    Unit = {
      Description = "Conky system monitor";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.conky}/bin/conky -c ${config.home.homeDirectory}/.config/conky/conky.conf";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # 📄 Link or embed your external Conky config
  # You can use .source (symlink) or .text (embed file contents)
  # If mirach.conf is in the same directory as this Nix file:
  home.file.".config/conky/conky.conf".source = ./mirach/mirach.conf;
}

