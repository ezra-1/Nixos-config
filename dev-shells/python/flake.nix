{
  description = " Nix flake for a Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # or FlakeHub if preferred
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
              # overlays = [];  # Add custom overlays if needed
            };
          });

      /*
        Change this value ({major}.{min}) to update the Python
        virtual environment version. After changing, delete `.venv`
        and reload the dev shell so the environment rebuilds cleanly.
      */
      version = "3.13";

      # Helper to extract major+minor for matching python attr
      concatMajorMinor = v:
        nixpkgs.lib.pipe v [
          nixpkgs.lib.versions.splitVersion
          (nixpkgs.lib.sublist 0 2)
          nixpkgs.lib.concatStrings
        ];
    in
    {
      devShells = forAllSystems ({ pkgs }: let
        python = pkgs."python${concatMajorMinor version}";
      in {
        default = pkgs.mkShell {
          name = "python-${version}-dev-shell";

          venvDir = ".venv";

          packages = with python.pkgs; [
            venvShellHook
            pip
            # --- Common dev tools (uncomment as needed) ---
            # black
            # ruff
            # pytest
            # basedpyright
          ];

          postShellHook = ''
            venvVersionWarn() {
              if [[ -x "$venvDir/bin/python" ]]; then
                local venvVersion
                venvVersion="$("$venvDir/bin/python" -c 'import platform; print(platform.python_version())')"

                if [[ "$venvVersion" != "${python.version}" ]]; then
                  cat <<EOF
              ⚠️  Python version mismatch:
                  venv: $venvVersion
                  shell: ${python.version}
              Please delete '$venvDir' and reload the shell.
              EOF
                fi
              fi
            }

            echo " Entered Python ${python.version} development shell"
            venvVersionWarn
          '';
        };
      });
    };
}

