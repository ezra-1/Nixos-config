{ inputs, host, pkgs, lib, ... }:

{
  # ------------------------------------------------------
  # 🧩 System Packages — Dependencies for Neovim
  # ------------------------------------------------------
  home.packages = with pkgs; [
    gcc          # Compile Treesitter parsers
    nodejs       # Required for LSPs & plugins
    nil          # Nix LSP
    nixfmt-tree  # Nix formatter
    ripgrep      # Fuzzy finding (Telescope, etc.)
  ];

  # ------------------------------------------------------
  # 🧠 Neovim Setup
  # ------------------------------------------------------
  programs.neovim.enable = true;

  # Link Neovim configuration from your flake input
  xdg.configFile."nvim".source = inputs.neovim;

  # ------------------------------------------------------
  # 🖥️ Desktop Entry
  # ------------------------------------------------------
  xdg.desktopEntries.nvim = {
    name = "Neovim wrapper";
    genericName = "Text Editor";
    comment = "Edit text files";

    # ✅ Fixed: removed invalid single quotes — .desktop spec does not allow them
    exec = "${lib.getExe pkgs.kitty} --class nvim-wrapper -e nvim %F";

    icon = "nvim";
    mimeType = [
      "text/plain"
      "text/x-makefile"
    ];

    # ✅ Add 'Utility' for better desktop-categorization compliance
    categories = [
      "Utility"
      "Development"
      "TextEditor"
    ];

    terminal = false; # False since we're launching via terminal binary directly
  };
}

