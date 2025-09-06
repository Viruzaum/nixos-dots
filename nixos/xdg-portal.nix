{
  pkgs,
  config,
  ...
}: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    configPackages = [config.programs.niri.package];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
