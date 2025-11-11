{
  description = " Nix flake: Zig development environment";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
  };

  outputs = inputs:
  let
    lib = inputs.nixpkgs.lib;

    # Supported systems
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    # Helper to apply across all systems
    forEachSystem = f: lib.genAttrs supportedSystems (system:
      f {
        pkgs = import inputs.nixpkgs { inherit system; };
      });
  in {
    # --------------------------------------------------------
    # 🧪 Dev Shells
    # --------------------------------------------------------
    devShells = forEachSystem ({ pkgs }: {
      default = pkgs.mkShell {
        name = "zig-dev-shell";

        packages = with pkgs; [
          zig    # Zig compiler
          zls    # Zig language server
          lldb   # Debugger
        ];

        shellHook = ''
          echo " Entered Zig development environment"
          echo "Zig version: $(zig version)"
        '';
      };
    });
  };
}

