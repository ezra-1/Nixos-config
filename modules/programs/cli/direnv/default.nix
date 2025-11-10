{ ... }:

{
  # ------------------------------------------------------
  # Direnv Configuration
  # ------------------------------------------------------
  programs.direnv = {
    enable = true;

    # Enable shell integrations
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = false;
    enableNushellIntegration = false;

    # Optional: use direnv’s built-in nix-direnv integration
    nix-direnv.enable = true;
  };

  # ------------------------------------------------------
  # Environment Variables
  # ------------------------------------------------------
  home.sessionVariables = {
    DIRENV_WARN_TIMEOUT = "60s";
  };
}

