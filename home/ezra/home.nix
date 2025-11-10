{
  config,
  lib,
  pkgs,
  imports,
  ...
}: {
  # --------------------------------------------------------
  # 🧩 Imports — bring in custom modules and host-level logic
  # --------------------------------------------------------
  imports = [
    ../../modules/core/zsh
    ../../modules/programs/cli/direnv
    ../../modules/programs/media/spicetify
    ../../modules/programs/media/discord
    ../../modules/programs/editor/vscode
    ../../modules/programs/editor/neovim
    ../../modules/desktop/plasma6
    ../../modules/programs/browser/zen
  ];

  # --------------------------------------------------------
  # 🏠 Basic user configuration
  # --------------------------------------------------------
  home = {
    username = lib.mkDefault "ezra";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "25.05"; # Match Home Manager release
  };

  # --------------------------------------------------------
  # 📦 Packages — user-level software
  # --------------------------------------------------------
  home.packages = with pkgs; [
    git
    eza
    bat
    htop
    wget
    kitty
    fastfetch
    spicetify-cli
    dwt1-shell-color-scripts

    # 🖋️ Fonts
    nerd-fonts.jetbrains-mono
  ];

  # --------------------------------------------------------
  # ⚙️ Environment variables
  # --------------------------------------------------------
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "en_US.UTF-8";
  };

  # --------------------------------------------------------
  # 🧩 Dotfiles & config files
  # --------------------------------------------------------
  home.file = {
    ".config/neofetch/config.conf".text = ''
      print_info() {
        info "User" "$USER"
        info "Host" "$HOSTNAME"
        info "OS" "$distro"
        info "Kernel" "$kernel"
        info "Uptime" "$uptime"
      }
    '';
  };

  # --------------------------------------------------------
  # 🧰 Programs managed by Home Manager
  # --------------------------------------------------------
  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      settings = {
        user = {
          name = "Ezra Lawrence";
          email = "ezralawrence02@gmail.com";
        };
        init.defaultBranch = "main";
        alias = {
          co = "checkout";
          br = "branch";
          ci = "commit";
          st = "status";
          last = "log -1 HEAD";
        };
        pull.rebase = true;
        push.autoSetupRemote = true;
        color.ui = "auto";
      };
    };
  };

  # --------------------------------------------------------
  # 🧹 Misc
  # --------------------------------------------------------
  # home-manager manages itself; nothing else needed here.
}

