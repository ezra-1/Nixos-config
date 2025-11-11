{
  description = " Deno development environment (Nix flake)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
            pkgs = import nixpkgs { inherit system; };
          });
    in
    {
      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          name = "deno-dev-shell";

          buildInputs = with pkgs; [
            deno
            git    # optional: version control
          ];

          shellHook = ''
            echo " Entered Deno dev shell"
            echo "deno version: $(deno --version)"
          '';
        };
      });
    };
}

