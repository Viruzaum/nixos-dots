{...}: {
  hardware.opengl.driSupport32Bit = true;
  programs.steam.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({extraLibraries ? pkgs': [], ...}: {
        extraLibraries = pkgs':
          (extraLibraries pkgs')
          ++ [
            pkgs'.gperftools
            pkgs'.mangohud
            pkgs'.gamemode
          ];
      });
    })
  ];

  programs.gamemode.enable = true;
  programs.steam.gamescopeSession.enable = true;
}
