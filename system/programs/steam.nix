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

  programs.gamemode.enable = true;
}
