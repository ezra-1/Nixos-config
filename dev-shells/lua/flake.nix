{
  description = " Lua development environment (Nix flake)";

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
          name = "lua-dev-shell";

          buildInputs = with pkgs; [
            lua
            luajit      # optional JIT-enabled Lua runtime
            luarocks    # Lua package manager
          ];

          shellHook = ''
            echo " Entered Lua dev shell"
            echo "Lua version: $(lua -v)"
            echo "LuaJIT version: $(luajit -v 2>/dev/null || true)"
          '';
        };
      });
    };
}

