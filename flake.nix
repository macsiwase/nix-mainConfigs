{
  description = "Mac's NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org"
    ];
    extra-substituters = [
      # nix-community's cache server
      "https://nix-community.cachix.org"
    ];
  };

  inputs = {
    # Nixpkgs
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware/master";

    # Declarative themes and wallpapers with nix-colors 
    nix-colors.url = "github:misterio77/nix-colors";
    
    # Opt-in persistence through impermanence + blank snapshotting
    #impermanence.url = "github:nix-community/impermanence";
    
    # Deployment secrets using sops-nix
    sops-nix.url = "github:mic92/sops-nix";

    #hyprland = {
    #   url = "github:hyprwm/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    #hyprwm-contrib = {
    #  url = "github:hyprwm/contrib";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    
    #firefox-addons = {
    #  url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs; 
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ 
        "x86_64-linux" 
        "aarch64-linux"
      ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
      inherit lib;
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;

      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      templates = import ./templates;

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs outputs; };

      #hydraJobs = import ./hydra.nix { inherit inputs outputs; };

      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; }); 

      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; }); 

      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      wallpapers = import ./home/nixmac/wallpapers;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#hostname'
      nixosConfigurations = {
        # Main
        nixos = lib.nixosSystem {
          modules = [ ./hosts/nixos ];
          specialArgs = { inherit inputs outputs; };
        };

	# AMD Laptop: Thinkpad T14 Gen 1
        nixAMD = lib.nixosSystem {
          modules = [ ./hosts/nixAMD ];
          specialArgs = { inherit inputs outputs; };
        };

	# NVIDIA Laptop: XMG Fusion 15 Intel
        nixNVIDIA = lib.nixosSystem {
          modules = [ ./hosts/nixNVIDIA ];
          specialArgs = { inherit inputs outputs; };
        };

	# kvm-qemu laptop
        nixKVM = lib.nixosSystem {
          modules = [ ./hosts/nixKVM ];
          specialArgs = { inherit inputs outputs; };
        }; 
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#username@hostname'
      homeConfigurations = {
        "nixmac@nixos" = lib.homeManagerConfiguration {
	  modules = [ ./home/nixmac/nixos.nix ];
          pkgs = pkgsFor.x86_64-linux; 
          extraSpecialArgs = { inherit inputs outputs; };
          };
	
	"nixmac@nixAMD" = lib.homeManagerConfiguration {
          modules = [ ./home/nixmac/nixAMD.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };

	"nixmac@nixNVIDIA" = lib.homeManagerConfiguration {
	  modules = [ ./home/nixmac/nixNVIDIA.nix ];
	  pkgs = pkgsFor.x86_64-linux;
	  extraSpecialArgs = { inherit inputs outputs; };
        };	

	"nixmac@nixKVM" = lib.homeManagerConfiguration {
          modules = [ ./home/nixmac/nixKVM.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };

	"nixmac@generic" = lib.homeManagerConfiguration {
          modules = [ ./home/nixmac/generic.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
      };
    };
  };
}
