{pkgs, ...}: {
  hardware.graphics.enable32Bit = true;

  programs.steam = {
    enable = true;

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

          openssl_1_1

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

  programs.gamemode.enable = true;
}
