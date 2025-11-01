{
  description = '' 🧊 Ezra’s NixOS & Home Manager configuration. '';

  # ------------------------------------------------------
  # Inputs
  # ------------------------------------------------------
  inputs = {
    # ------------------ Nixpkgs ------------------
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # ------------------ Home Manager ------------------
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # ------------------ Better Blur -------------------
    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ------------------- Spicetify Nix -----------------
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ------------------------------------------------------
  # Outputs
  # ------------------------------------------------------
  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: 

  let
    inherit (self) outputs;

    # Supported systems (Linux + macOS)
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    # Helper: apply a function to all systems
    forAllSystems = nixpkgs.lib.genAttrs systems;

  in {

    # ------------------------------------------------------
    # Packages
    # ------------------------------------------------------
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # ------------------------------------------------------
    # Overlays
    # ------------------------------------------------------
    overlays = import ./overlays { inherit inputs; };

    # ------------------------------------------------------
    # NixOS Configurations
    # ------------------------------------------------------
    nixosConfigurations = {
      ezra = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/ezra ];
      };
    };

    # ------------------------------------------------------
    # Home Manager Configurations
    # ------------------------------------------------------
    homeConfigurations = {
      "ezra" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [ 
          ./home/ezra/ezra.nix
          inputs.spicetify-nix.homeManagerModules.default
        ];
      };
    };
  };
}


