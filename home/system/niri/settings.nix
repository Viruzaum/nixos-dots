{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
    settings = {
      debug = {
        honor-xdg-activation-with-invalid-serial = {};
      };
      environment = {
        DISPLAY = ":0";
      };
      spawn-at-startup = [
        {command = ["${lib.getExe pkgs.xwayland-satellite}"];}
      ];
      input = {
        keyboard.xkb.layout = "br";
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus.enable = true;
        focus-follows-mouse.max-scroll-amount = "0%";
      };
      layout = {
        default-column-width.proportion = 1.0;
        preset-column-widths = [
          {proportion = 1. / 3.;}
          {proportion = 1. / 2.;}
          {proportion = 2. / 3.;}
        ];
        background-color = "transparent";
      };
      overview.workspace-shadow.enable = false;
      screenshot-path = "/home/viruz/pictures/screenshots/%Y-%m-%d-%H-%M-%S.png";
      outputs = {
        "LVDS-1" = {
          enable = true;
        };
        "HDMI-A-1".enable = true;
      };
      clipboard.disable-primary = true;
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
    };
  };
}
