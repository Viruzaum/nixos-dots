{
  inputs,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.system}.default;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        margin = "0";
        spacing = 2;

        modules-left = ["clock" "hyprland/window"];
        modules-center = ["hyprland/workspaces"];
        modules-right = ["tray" "cpu" "temperature" "memory" "pulseaudio"];

        "hyprland/window" = {
          format = "{title}";
          max-length = 333;
          seperate-outputs = true;
        };
        "clock" = {
          format = "<span foreground='#e6b673'> </span><span>{:%H:%M %a %d}</span>";
          tooltip-format = "{calendar}";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>{%W}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b>{}</b></span>";
            };
            actions = {
              on-click-middle = "mode";
              on-click-right = "shift_up";
              on-click = "shift_down";
            };
          };
        };
        "cpu" = {
          format = "<span foreground='#aad94c'>󰯳</span> {usage}%";
          interval = 1;
        };
        "memory" = {
          format = "<span foreground='#d2a6ff'>󰍛</span> {}%";
          interval = 1;
        };
        "temperature" = {
          critical-threshold = 80;
          format = "<span foreground='#f29668'></span> {temperatureC}°C";
          interval = 1;
        };
        "pulseaudio" = {
          format = "<span foreground='#f26d78'>{icon}</span> {volume}%  {format_source}";
          format-bluetooth = "<span foreground='#95e6cb'>{icon}</span> {volume}%  {format_source}";
          format-bluetooth-muted = "<span foreground='#95e6cb'>
󰖁</span>  {format_source}";
          format-muted = "<span foreground='#F38BA8'>󰖁</span>  {format_source}";
          format-source = "<span foreground='#fab387'></span> {volume}%";
          format-source-muted = "<span foreground='#F38BA8'></span>";
          format-icons = {
            headphone = "";
            phone = "";
            portable = "";
            default = ["" "" ""];
          };
          on-click-left = "pavucontrol";
          input = true;
        };
        "tray" = {
          format = "<span foreground='#957FB8'>{icon}</span>";
          icon-size = 14;
          spacing = 5;
        };
      };
    };
  };
}
