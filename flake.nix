{
  description = "Viruz Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    #hyprland.url = "github:hyprwm/Hyprland";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    nix-gaming.url = "github:fufexan/nix-gaming";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    stylix,
    nix-index-database,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs {
      overlays = [inputs.nur.overlay];
      system = system;
      config.allowUnfree = true;
    };
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    nixosConfigurations = {
      viruz-nix = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [./configuration.nix];
      };
    };
    homeConfigurations."viruz" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {inherit inputs;};

      modules = [
        stylix.homeManagerModules.stylix
        nix-index-database.hmModules.nix-index
        ./home.nix
      ];
    };
  };
}
