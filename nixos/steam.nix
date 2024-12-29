{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];
  # jovian.steam = {
  #   enable = true;
  #   autoStart = true;
  #   user = "viruz";
  #   desktopSession = "hyprland";
  # };

  hardware.graphics.enable32Bit = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    platformOptimizations.enable = true;

    # fix gamescope inside steam
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          keyutils
          libkrb5
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver

          # openssl_1_1 # Fix Devil Daggers

          mangohud
        ];
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({extraLibraries ? pkgs': [], ...}: {
        extraLibraries = pkgs':
          (extraLibraries pkgs')
          ++ [
            pkgs'.gperftools
          ];
      });
    })
  ];

  # Fix Devil Daggers
  nixpkgs.config.permittedInsecurePackages = [
    # "openssl-1.1.1w"
  ];

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
}
