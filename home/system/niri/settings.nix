{
  pkgs,
  lib,
  ...
}: {
  programs.niri = {
    package = pkgs.niri-stable;
    settings = {
      debug = {
        honor-xdg-activation-with-invalid-serial = {};
      };
      environment = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
        DISPLAY = ":3";
      };
      spawn-at-startup = [
        {command = [(lib.getExe' pkgs.systemd "systemctl") "--user" "set-environment" "DISPLAY=:3"];}
        {command = [(lib.getExe pkgs.xwayland-satellite) ":3"];}
        {command = [(lib.getExe pkgs.fcitx5) "-d"];}
      ];
      input = {
        keyboard.xkb.layout = "br";
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus.enable = true;
        focus-follows-mouse.max-scroll-amount = "0%";
      };
      layout = {
        empty-workspace-above-first = true;
        default-column-width.proportion = 0.5;
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
        "HDMI-A-1".enable = true;
      };
      clipboard.disable-primary = true;
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
    };
  };
}
