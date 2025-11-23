{
  description = "  A Nix flake providing a reproducible Node.js development environment";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
  };

  outputs = inputs:
  let
    # Supported systems: Linux & macOS (x86_64 + ARM64)
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    # Apply a function to all systems
    forEachSystem = f:
      inputs.nixpkgs.lib.genAttrs supportedSystems (
        system:
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
    # Overlay: customize packages
    # ------------------------------------------------------
    overlays.default = final: prev: {
      # Use Node 24
      nodejs = prev.nodejs_24;

      # Avoid default yarn using wrong Node version
      yarn = prev.yarn.override { nodejs = final.nodejs; };
    };

    # ------------------------------------------------------
    # DevShell
    # ------------------------------------------------------
    devShells = forEachSystem ({ pkgs }: {
      default = pkgs.mkShell {
        name = "nodejs-dev-shell";

        packages = with pkgs; [
          nodejs
          node2nix
          nodePackages.pnpm
          yarn

          # ⭐ Add Prettier globally inside devShell
          nodePackages.prettier
        ];

        shellHook = ''
          echo "  Node.js development environment ready!"
          echo "Node: $(node --version)"
          echo "Yarn: $(yarn --version)"
          echo "PNPM: $(pnpm --version)"
          echo "Prettier: $(prettier --version)"
        '';
      };
    });
  };
}
