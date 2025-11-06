{
  description = "󱄅 Nix flake for Nix development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # or FlakeHub if you prefer
  };

  outputs = { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system:
          f {
            pkgs = import nixpkgs {
              inherit system;
              # overlays = [];
            };
          });
    in
    {
      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          name = "nix-dev-shell";

          buildInputs = with pkgs; [
            # --- Nix tooling ---
            nixd                # Nix language server (LSP)
            nixfmt-classic      # Formatter
            statix              # Linter
            vulnix              # Vulnerability scanner
            cachix              # Binary cache manager
            lorri               # direnv integration
            niv                 # Legacy dependency manager
            haskellPackages.dhall-nix # Dhall → Nix translator

            # --- Optional extras (uncomment as needed) ---
            # alejandra          # Alternative Nix formatter
            # deadnix            # Find dead code
            # nixpkgs-fmt        # Fast modern formatter
            # direnv             # Useful for automatic shell activation
          ];

          shellHook = ''
            echo "󱄅 Entered Nix development shell"
            echo "nix version: $(nix --version)"
          '';
        };
      });
    };
}

