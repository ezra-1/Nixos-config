{ config, pkgs, lib, inputs, outputs, ... }:

{
  # --------------------------------------------------------
  # Imports
  # --------------------------------------------------------
  imports = [
    ./hardware-configuration.nix
  ];

  # --------------------------------------------------------
  # Bootloader
  # --------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "b43" ];
  hardware.firmware = [ pkgs.b43Firmware_5_1_138 ];

  # --------------------------------------------------------
  # Networking & Bluetooth
  # --------------------------------------------------------
  networking.hostName = "ezra";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # --------------------------------------------------------
  # Desktop environment
  # --------------------------------------------------------
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # --------------------------------------------------------
  # Users
  # --------------------------------------------------------
  users.users.ezra = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

  # --------------------------------------------------------
  # Programs
  # --------------------------------------------------------
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  # --------------------------------------------------------
  # Nix settings
  # --------------------------------------------------------
  nixpkgs.config.allowUnfree = true;

  # --------------------------------------------------------
  # Packages
  # --------------------------------------------------------
  environment.systemPackages = with pkgs; [
    vim
    git
    fzf
    gcc
    curl
    wget
    unzip
    kitty
    vscode
    gnumake
    nodejs_24
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default  # Wayland
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.x11      # X11
  ];

  # --------------------------------------------------------
  # Services
  # --------------------------------------------------------
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.allowSFTP = true;

  #----------------------------------------------------------
  # Flatpak
  #----------------------------------------------------------
  services.flatpak.enable = true;

  # --------------------------------------------------------
  # Time & locale
  # --------------------------------------------------------
  time.timeZone = "America/Jamaica";
  i18n.defaultLocale = "en_US.UTF-8";
  
  # --------------------------------------------------------
  # Qt configuration
  # --------------------------------------------------------
  qt = {
    enable = true;
    style = "kvantum";
  };

  # --------------------------------------------------------
  # System version
  # --------------------------------------------------------
  system.stateVersion = "25.05"; # matches your NixOS version
}
