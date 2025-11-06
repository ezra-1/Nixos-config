{
  description = " Nix flake for a Shell scripting development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # or use FlakeHub if you prefer
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
          name = "shell-dev-shell";

          buildInputs = with pkgs; [
            shellcheck  # static analysis for shell scripts
            shfmt        # formatter
            bash-language-server # LSP for editors
          ];

          shellHook = ''
            echo " Entered Shell development environment"
            echo "ShellCheck version: $(shellcheck --version | head -n 1)"
          '';
        };
      });
    };
}

