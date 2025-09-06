{pkgs, ...}: {
  imports = [
    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];

  home = {
    packages = with pkgs; [
      seatd
      jaq
      loupe
    ];
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
