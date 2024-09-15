{
  pkgs,
  ...
}:
# Wayland config
{
  imports = [
    ./hyprland
    # ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    # screenshot
    # grim
    # slurp

    # utils
    (pkgs.callPackage ../../../pkgs/wl-ocr {})
    wl-clipboard
    wl-screenrec
    wlr-randr
    wev
    xdg-utils
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    feh
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    # SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
