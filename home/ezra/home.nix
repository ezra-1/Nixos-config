{ config, lib, pkgs, imports, ... }:

{
  # --------------------------------------------------------
  # 🧩 Imports — bring in custom modules and host-level logic
  # --------------------------------------------------------
  imports = [
    # Add more modules here, e.g.:
    # ../../modules/system/gnome.nix
    # ../../modules/network.nix
    ../../modules/programs/media/spicetify   
  ];

  # --------------------------------------------------------
  # 🏠 Basic user configuration
  # --------------------------------------------------------
  home.username = lib.mkDefault "ezra";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  # Match your current Home Manager release
  home.stateVersion = "25.05";

  # --------------------------------------------------------
  # 📦 Packages — install user-level software here
  # --------------------------------------------------------
  home.packages = with pkgs; [
    git
    eza
    bat
    htop
    wget
    kitty
    neovim
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
    EDITOR = "neovim";
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

    # ---------------- Git ----------------
    git = {
      enable = true;

      # Git user info
      settings.user.name  = "ezra";
      settings.user.email = "ezralawrence02@gmail.com";

      # Default branch name for new repos
      settings.init.defaultBranch = "main";

      # Git aliases
      settings.alias = {
        co   = "checkout";
        br   = "branch";
        ci   = "commit";
        st   = "status";
        last = "log -1 HEAD";
      };
    };

    # ---------------- Bash ----------------
    # Uncomment if you want Bash instead of Zsh
    # bash = {
    #   enable = true;
    #   enableCompletion = true;
    #   shellInit = ''
    #     PS1="\[\e[1;32m\][\u@\h:\w]\$\[\e[0m\] "
    #   '';
    # };

    # ---------------- Zsh ----------------
    zsh = {
      enable = true;
       autosuggestion.enable = true;
       syntaxHighlighting.enable = true;
       historySubstringSearch.enable = true;
       initContent = builtins.readFile ./zsh/zshrc;
    };
  };

  # --------------------------------------------------------
  # 🧹 Misc
  # --------------------------------------------------------
  # (home-manager is already managed by itself)
}
