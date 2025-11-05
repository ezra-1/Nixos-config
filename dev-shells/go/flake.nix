{
  description = "🐹 A Nix flake providing a reproducible Go 1.24 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    let
      goVersion = 24; # change this to 25, 26, etc., when newer Go versions arrive

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachSupportedSystem =
        f:
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
      overlays.default = final: prev: {
        go = final."go_1_${toString goVersion}";
      };

      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            name = "go-dev-shell";

            packages = with pkgs; [
              go
              gotools
              golangci-lint
              git
            ];

            shellHook = ''
              echo ""
              echo "🐹 Go ${toString goVersion} development environment ready!"
              echo "----------------------------------------------"
              go version
              golangci-lint --version || true
              echo ""
            '';
          };
        }
      );

      formatter = forEachSupportedSystem ({ pkgs }: pkgs.nixfmt);

      checks = forEachSupportedSystem (
        { pkgs }:
        {
          go-version = pkgs.runCommand "go-version" { } ''
            ${pkgs.go}/bin/go version > $out
          '';
        }
      );
    };
}
