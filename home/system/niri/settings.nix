{
  pkgs,
  lib,
  ...
}: {
  programs.niri = {
    settings = {
      debug = {
        honor-xdg-activation-with-invalid-serial = {};
      };
      environment = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
      };
      spawn-at-startup = [
        {command = ["qs" "-c" "meow"];}
        {command = [(lib.getExe pkgs.fcitx5) "-d"];}
      ];
      input = {
        keyboard.xkb = {
          layout = "br";
          options = "ctrl:nocaps";
        };
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus.enable = true;
        focus-follows-mouse.max-scroll-amount = "50%";
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
