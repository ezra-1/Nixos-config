{
  description = "🧩 A Nix flake providing a reproducible Node.js development environment";

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

    # Helper: apply a function to all supported systems
    forEachSystem = f:
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
    # Overlay — customize packages
    # ------------------------------------------------------
    overlays.default = final: prev: {
      # Pick a specific Node.js version (avoid prev.nodejs)
      nodejs = prev.nodejs_22; 
      yarn = prev.yarn.override { nodejs = final.nodejs; };
    };

    # ------------------------------------------------------
    # Development Shells
    # ------------------------------------------------------
    devShells = forEachSystem ({ pkgs }: {
      default = pkgs.mkShell {
        name = "nodejs-dev-shell";
        packages = with pkgs; [
          node2nix
          nodejs
          nodePackages.pnpm
          yarn
        ];
        shellHook = ''
          echo "🚀 Node.js development environment ready!"
          node --version
          yarn --version
        '';
      };
    });
  };
}

