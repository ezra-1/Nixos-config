{ ... }:

{
  environment.variables."DIRENV_WARN_TIMEOUT" = "60s";
  programs.direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = false;
        enableNushellIntegration = false;
  };
}
