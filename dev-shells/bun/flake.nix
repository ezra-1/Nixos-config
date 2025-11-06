{
  description = " Bun development environment (Nix flake)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # or use FlakeHub if preferred
  };

  outputs = { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs systems (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
            # optionally include overlays or configuration here
          };
        });
    in
    {
      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          name = "bun-dev-shell";

          buildInputs = with pkgs; [
            bun
            nodejs # optional: for npm-related tooling
            git    # optional: version control
          ];

          shellHook = ''
            echo " Entered Bun dev shell"
            echo "bun version: $(bun --version)"
          '';
        };
      });
    };
}

