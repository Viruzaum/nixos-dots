{
  pkgs,
  config,
  lib,
  ...
}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "$pidof hyprlock || {lib.getExe pkgs.hyprlock}";
        unlock_cmd = "killall -USR1 hyprlock";
        before_sleep_cmd = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
        after_sleep_cmd = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
        ignore_dbus_inhibit = false;
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms off"; # screen off when timeout has passed
          on-resume = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on"; # screen on when activity is detected after timeout has fired.        }
        }
        {
          timeout = 630;
          on-timeout = "${lib.getExe' pkgs.deluge-gtk "deluge-console"} resume \"*\"";
          on-resume = "${lib.getExe' pkgs.deluge-gtk "deluge-console"} pause \"*\"";
        }
        {
          timeout = 600;
          on-timeout = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
        }
      ];
    };
  };
}
