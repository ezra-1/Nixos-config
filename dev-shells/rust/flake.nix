{
  description = " Nix flake: Rust development environment (via Fenix)";

  inputs = {
    # Core dependencies
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    fenix = {
      url = "https://flakehub.com/f/nix-community/fenix/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  let
    lib = inputs.nixpkgs.lib;

    # Define supported systems
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    # Helper for all systems
    forEachSystem = f: lib.genAttrs supportedSystems (system:
      f {
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ inputs.self.overlays.default ];
        };
      });
  in {
    # --------------------------------------------------------
    # 🧩 Overlay: custom Rust toolchain via Fenix
    # --------------------------------------------------------
    overlays.default = final: prev: {
      rustToolchain = with inputs.fenix.packages.${prev.stdenv.hostPlatform.system};
        combine (with stable; [
          rustc
          cargo
          clippy
          rustfmt
          rust-src
        ]);
    };

    # --------------------------------------------------------
    # 🧪 Dev Shells
    # --------------------------------------------------------
    devShells = forEachSystem ({ pkgs }: {
      default = pkgs.mkShell {
        name = "rust-dev-shell";

        packages = with pkgs; [
          rustToolchain
          openssl
          pkg-config
          cargo-deny
          cargo-edit
          cargo-watch
          rust-analyzer
        ];

        env = {
          # Required by rust-analyzer
          RUST_SRC_PATH = "${pkgs.rustToolchain}/lib/rustlib/src/rust/library";
        };

        shellHook = ''
          echo " Rust development environment ready!"
          echo "Toolchain: $(rustc --version)"
        '';
      };
    });
  };
}

