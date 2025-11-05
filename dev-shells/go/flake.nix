{
  description = "🐹 A Nix flake providing a reproducible Go 1.23 development environment";

  # ------------------------------------------------------
  # Inputs
  # ------------------------------------------------------
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
  };

  # ------------------------------------------------------
  # Outputs
  # ------------------------------------------------------
  outputs = inputs:
  let
    # ------------------------------------------------------
    # Go version selector (change this to bump Go)
    # ------------------------------------------------------
    goVersion = 23;

    # Supported systems (Linux + macOS)
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    # Helper: apply a function to all supported systems
    forEachSupportedSystem = f:
      inputs.nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ inputs.self.overlays.default ];
          };
        }
      );
  in
  {
    # ------------------------------------------------------
    # Overlay — pin and expose specific Go version
    # ------------------------------------------------------
    overlays.default = final: prev: {
      go = final."go_1_${toString goVersion}";
    };

    # ------------------------------------------------------
    # Development Shells
    # ------------------------------------------------------
    devShells = forEachSupportedSystem ({ pkgs }: {
      default = pkgs.mkShell {
        name = "go-dev-shell";

        packages = with pkgs; [
          go              # Go (version pinned above)
          gotools         # goimports, godoc, etc.
          golangci-lint   # Static analysis and linting
        ];

        # Optional: Friendly startup message
        shellHook = ''
          echo ""
          echo "Go ${goVersion} development environment ready!"
          echo "----------------------------------------------"
          go version
          golangci-lint --version || true
          echo ""
        '';
      };
    });

    # ------------------------------------------------------
    # Formatter (optional, used by nix fmt)
    # ------------------------------------------------------
    formatter = forEachSupportedSystem ({ pkgs }: pkgs.nixfmt);

    # ------------------------------------------------------
    # CI Checks (optional)
    # ------------------------------------------------------
    checks = forEachSupportedSystem ({ pkgs }: {
      go-version = pkgs.runCommand "go-version" {} ''
        ${pkgs.go}/bin/go version > $out
      '';
    });
  };
}

