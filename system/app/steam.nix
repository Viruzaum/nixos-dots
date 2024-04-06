{pkgs, ...}: {
  hardware.opengl.driSupport32Bit = true;

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

  #programs.gamemode.enable = true;
  #programs.steam.gamescopeSession.enable = true;
}
