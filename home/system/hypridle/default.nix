{
  pkgs,
  inputs,
  lib,
  ...
}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        # lock_cmd = lib.getExe inputs.hyprlock.packages.${pkgs.system}.hyprlock;
        lock_cmd = lib.getExe pkgs.hyprlock;
        unlock_cmd = "killall -USR1 hyprlock";
        before_sleep_cmd = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
        # after_sleep_cmd = "${lib.getExe' inputs.hyprland.packages.${pkgs.system}.hyprland "hyprctl"} dispatch dpms on";
        after_sleep_cmd = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
        ignore_dbus_inhibit = false;
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "${lib.getExe pkgs.brightnessctl} -s set 0";
          on-resume = "${lib.getExe pkgs.brightnessctl} -r";
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
