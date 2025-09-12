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
    SDL_VIDEODRIVER = "wayland,x11";
    XDG_SESSION_TYPE = "wayland";
    QT_IM_MODULE = "fcitx";
  };
}
