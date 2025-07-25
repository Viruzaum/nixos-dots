{
  description = "viruz Flake";

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        ./hosts
      ];

      perSystem = {pkgs, ...}: {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.alejandra
            pkgs.nixd
            pkgs.git
          ];
          name = "dots";
        };

        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    # global stuff that are followed

    systems.url = "github:nix-systems/default-linux";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    kuroneko.url = "git+ssh://git@codeberg.org/viruz/kuroneko.git";

    # other stuff in alphabetical order

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        systems.follows = "systems";
      };
    };

    anyrun = {
      url = "github:anyrun-org/anyrun";
    };

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # helix = {
    #   url = "github:helix-editor/helix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # hyprlock = {
    #   url = "github:hyprwm/hyprlock";
    #   inputs = {
    #     hyprlang.follows = "hyprland/hyprlang";
    #     hyprutils.follows = "hyprland/hyprutils";
    #     nixpkgs.follows = "hyprland/nixpkgs";
    #     systems.follows = "hyprland/systems";
    #   };
    # };

    # hypridle = {
    #   url = "github:hyprwm/hypridle";
    #   inputs = {
    #     hyprlang.follows = "hyprland/hyprlang";
    #     hyprutils.follows = "hyprland/hyprutils";
    #     nixpkgs.follows = "hyprland/nixpkgs";
    #     systems.follows = "hyprland/systems";
    #   };
    # };

    # hyprpaper = {
    #   url = "github:hyprwm/hyprpaper";
    #   inputs = {
    #     hyprlang.follows = "hyprland/hyprlang";
    #     hyprutils.follows = "hyprland/hyprutils";
    #     nixpkgs.follows = "hyprland/nixpkgs";
    #     systems.follows = "hyprland/systems";
    #   };
    # };

    # hyprpolkitagent = {
    #   url = "github:hyprwm/hyprpolkitagent";
    #   inputs = {
    #     hyprutils.follows = "hyprland/hyprutils";
    #     nixpkgs.follows = "hyprland/nixpkgs";
    #     systems.follows = "hyprland/systems";
    #   };
    # };

    # hypr-contrib = {
    #   url = "github:hyprwm/contrib";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # hyprpanel = {
    #   url = "github:viruzaum/HyprPanel/master";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyprland.url = "github:hyprland-community/pyprland";

    quickshell = {
      url = "github:quickshell-mirror/quickshell?ref=v0.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    umu = {
      url = "git+https://github.com/Open-Wine-Components/umu-launcher/?dir=packaging\/nix&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker.url = "github:abenz1267/walker";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
