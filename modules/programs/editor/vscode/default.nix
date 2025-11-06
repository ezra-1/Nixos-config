{ lib, pkgs, ... }:

{
  # --------------------------------------------------------
  # 🧩 Allow Unfree — Required for VSCode
  # --------------------------------------------------------
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "vscode" ];

  # --------------------------------------------------------
  # 💻 VSCode Setup
  # --------------------------------------------------------
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    package = pkgs.vscode;
    # package = pkgs.vscodium; # optional alternative

    profiles.default = {
      # ----------------------------------------------------
      # 📦 Extensions
      # ----------------------------------------------------
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        arrterian.nix-env-selector
        eamodio.gitlens
        github.vscode-github-actions
        yzhang.markdown-all-in-one
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        jnoortheen.nix-ide
        pkief.material-icon-theme
        # asvetliakov.vscode-neovim
        # vscodevim.vim
        # tamasfe.even-better-toml
        # redhat.vscode-yaml
        # rust-lang.rust-analyzer
        # ms-vscode.cpptools
        # ms-dotnettools.csharp
        # ms-python.python
      ];

      # ----------------------------------------------------
      # ⌨️ Keybindings
      # ----------------------------------------------------
      keybindings = [
        {
          key = "ctrl+q";
          command = "editor.action.commentLine";
          when = "editorTextFocus && !editorReadonly";
        }
        {
          key = "ctrl+s";
          command = "workbench.action.files.saveFiles";
        }
      ];

      # ----------------------------------------------------
      # ⚙️ User Settings
      # ----------------------------------------------------
      userSettings = {
        # ------------------ General ------------------
        "update.mode" = "none";
        "window.titleBarStyle" = "custom";
        "window.menuBarVisibility" = "classic";
        "editor.fontSize" = 11;
        "editor.fontLigatures" = true;
        "workbench.startupEditor" = "none";
        "telemetry.enableCrashReporter" = false;
        "telemetry.enableTelemetry" = false;
        "security.workspace.trust.untrustedFiles" = "open";

        # ------------------ Appearance ------------------
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "material-icon-theme";
        "catppuccin.accentColor" = "mauve";
        "explorer.confirmDragAndDrop" = false;
        "editor.minimap.enabled" = false;
        "workbench.sideBar.location" = "left";
        "workbench.layoutControl.enabled" = false;
        "workbench.editor.limit.enabled" = true;
        "workbench.editor.limit.value" = 10;
        "workbench.editor.limit.perEditorGroup" = true;
        "explorer.openEditors.visible" = 0;
        "editor.scrollbar.vertical" = "hidden";
        "editor.scrollbar.horizontal" = "hidden";

        # ------------------ Git ------------------
        "git.enableSmartCommit" = true;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "gitlens.hovers.annotations.changes" = false;
        "gitlens.hovers.avatars" = false;

        # ------------------ Editor Behavior ------------------
        "editor.semanticHighlighting.enabled" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnPaste" = true;
        "editor.mouseWheelZoom" = true;
        "breadcrumbs.enabled" = true;
        "editor.stickyScroll.enabled" = false;
        "editor.renderControlCharacters" = false;

        # ------------------ Language Servers ------------------
        "gopls" = { "ui.semanticTokens" = true; };
        "C_Cpp.default.cStandard" = "gnu11";
        "C_Cpp.formatting" = "vcFormat";
        "C_Cpp.autocompleteAddParentheses" = true;
        "C_Cpp.clang_format_sortIncludes" = true;

        # ------------------ Vim Keybindings ------------------
        "vim.leader" = "<Space>";
        "vim.useCtrlKeys" = true;
        "vim.hlsearch" = true;
        "vim.useSystemClipboard" = true;

        "vim.handleKeys" = {
          "<C-f>" = true;
          "<C-a>" = false;
        };

        "vim.insertModeKeyBindings" = [
          {
            "before" = [ "k" "j" ];
            "after" = [ "<Esc>" "l" ];
          }
        ];

        "vim.normalModeKeyBindingsNonRecursive" = [
          # Navigation
          { "before" = [ "<S-h>" ]; "commands" = [ ":bprevious" ]; }
          { "before" = [ "<S-l>" ]; "commands" = [ ":bnext" ]; }

          # Splits
          { "before" = [ "leader" "v" ]; "commands" = [ ":vsplit" ]; }
          { "before" = [ "leader" "s" ]; "commands" = [ ":split" ]; }

          # Pane movement
          { "before" = [ "<C-h>" ]; "commands" = [ "workbench.action.focusLeftGroup" ]; }
          { "before" = [ "<C-j>" ]; "commands" = [ "workbench.action.focusBelowGroup" ]; }
          { "before" = [ "<C-k>" ]; "commands" = [ "workbench.action.focusAboveGroup" ]; }
          { "before" = [ "<C-l>" ]; "commands" = [ "workbench.action.focusRightGroup" ]; }

          # Essentials
          { "before" = [ "leader" "w" ]; "commands" = [ ":w!" ]; }
          { "before" = [ "leader" "q" ]; "commands" = [ ":q!" ]; }
          { "before" = [ "leader" "x" ]; "commands" = [ ":x!" ]; }

          # Diagnostics
          { "before" = [ "[" "d" ]; "commands" = [ "editor.action.marker.prev" ]; }
          { "before" = [ "]" "d" ]; "commands" = [ "editor.action.marker.next" ]; }

          # Utilities
          { "before" = [ "<leader>" "f" ]; "commands" = [ "workbench.action.quickOpen" ]; }
          { "before" = [ "<leader>" "p" ]; "commands" = [ "editor.action.formatDocument" ]; }
          { "before" = [ "g" "h" ]; "commands" = [ "editor.action.showDefinitionPreviewHover" ]; }
          { "before" = [ "<C-n>" ]; "commands" = [ "workbench.action.toggleSidebarVisibility" ]; }
        ];

        "vim.visualModeKeyBindings" = [
          { "before" = [ "<" ]; "commands" = [ "editor.action.outdentLines" ]; }
          { "before" = [ ">" ]; "commands" = [ "editor.action.indentLines" ]; }
          { "before" = [ "J" ]; "commands" = [ "editor.action.moveLinesDownAction" ]; }
          { "before" = [ "K" ]; "commands" = [ "editor.action.moveLinesUpAction" ]; }
          { "before" = [ "leader" "c" ]; "commands" = [ "editor.action.commentLine" ]; }
        ];
      };
    };
  };
}
 
