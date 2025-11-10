{ inputs, host, pkgs, ... }:

{
  # ------------------------------------------------------
  # 🧩 System Packages — Dependencies for Neovim
  # ------------------------------------------------------
  home.packages = with pkgs; [
    gcc                # Compile Treesitter parsers
    nodejs             # Required for LSPs & plugins
    nil                # Nix LSP
    nixfmt-tree        # Nix formatter
    ripgrep            # Fuzzy finding (Telescope, etc.)
  ];

  # ------------------------------------------------------
  # 🧠 Neovim Setup
  # ------------------------------------------------------
  programs.neovim.enable = true;

  # Use config from flake input (e.g., inputs.neovim = ./nvim)
  xdg.configFile."nvim".source = inputs.neovim;

  # ------------------------------------------------------
  # 🖥️ Desktop Entry
  # ------------------------------------------------------
  xdg.desktopEntries.nvim = {
    name = "Neovim wrapper";
    genericName = "Text Editor";
    comment = "Edit text files";
    exec = "${lib.getExe (lib.getAttr terminal pkgs)} --class 'nvim-wrapper' -e nvim %F";
    icon = "nvim";
    mimeType = [
      "text/plain"
      "text/x-makefile"
    ];
    categories = [
      "Development"
      "TextEditor"
    ];
    terminal = false; # Important: false since we’re calling the terminal manually
  };
}

