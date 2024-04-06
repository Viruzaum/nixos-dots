{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../app/terminal/alacritty.nix
    ../../app/yazi/yazi.nix
    ../../app/notification/mako.nix

    inputs.hyprland.homeManagerModules.default
    inputs.hyprpaper.homeManagerModules.hyprpaper
    inputs.hypridle.homeManagerModules.hypridle
    inputs.hyprlock.homeManagerModules.hyprlock
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, return, exec, alacritty"
          "$mod, code:24, killactive"

          "$mod SHIFT,code:24,exit"
          "$mod,code:41,fullscreen"
          "$mod,space,togglefloating"
          "$mod,code:33,pseudo"
          "$mod,code:55,togglesplit"

          "$mod,code:40,exec,fuzzel"
          "$mod,code:56,exec,firefox"
          ",pause,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          ",print,exec,${lib.getExe pkgs.grimblast} --notify --freeze copysave area \"$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png\""
          "SHIFT,print,exec,${lib.getExe pkgs.grimblast} --notify copysave active \"$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png\""
          "CTRL,print,exec,${lib.getExe pkgs.grimblast} --notify copysave output \"$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png\""

          "$mod,code:43,movefocus,l"
          "$mod,code:46,movefocus,r"
          "$mod,code:45,movefocus,u"
          "$mod,code:44,movefocus,d"

          "$mod SHIFT, code:43, swapwindow, l"
          "$mod SHIFT, code:46, swapwindow, r"
          "$mod SHIFT, code:45, swapwindow, u"
          "$mod SHIFT, code:44, swapwindow, d"

          "$mod, apostrophe, hyprexpo:expo, toggle"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList
            (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];
      env = [
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "QT_QPA_PLATFORM,wayland;xcb"
        "XDG_SESSION_TYPE,wayland"
        "WLR_DRM_NO_ATOMIC,1"
      ];
      monitor = ",preferred,auto,auto";
      general = {
        layout = "dwindle";
        cursor_inactive_timeout = 30;
        border_size = 2;
        no_cursor_warps = false;
        gaps_in = 0;
        gaps_out = 0;

        allow_tearing = true;
      };
      exec-once = [
        "waybar"
        "fcitx5 -d"
        "nicotine-plus"
        "vesktop"
      ];
      input = {
        kb_layout = "br, br-workman";
        kb_options = "caps:none, grp:alt_shift_toggle";
        accel_profile = "flat";
        follow_mouse = 1;
        sensitivity = 0;
      };
      misc = {
        vfr = true;
      };
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "float,title:^(Picture-in-Picture)$"
        "pin,title:^(Picture-in-Picture)$"
        "keepaspectratio,title:^(Picture-in-Picture)$"
        "keepaspectratio,class:^(mpv)$"
        "workspace 3,class:^(vesktop)$"
        "workspace 2,class:^(firefox)$"
        "immediate,class:^(osu!)$"
        "immediate,class:^(Team Fortress 2 - OpenGL)$"
      ];
    };
    extraConfig = ''
      plugin {
        hyprexpo {
          columns = 3
          gap_size = 5
          bg_col = rgb(111111)
          workspace_method = center current # [center/first] [workspace] e.g. first 1 or center m+1

          enable_gesture = true # laptop touchpad, 4 fingers
          gesture_distance = 300 # how far is the "max"
          gesture_positive = true # positive = swipe down. Negative = swipe up.
        }
      }
    '';
    xwayland.enable = true;
    systemd.enable = true;
  };

  services.hyprpaper = {
    enable = true;
    ipc = false;
    preloads = [
      "/home/viruz/arisu/wallpaper.png"
    ];
    wallpapers = [
      ",/home/viruz/arisu/wallpaper.png"
    ];
  };

  services.hypridle = {
    enable = true;
    listeners = [
      {
        timeout = 300;
        onTimeout = "${lib.getExe' inputs.hyprland.packages.${pkgs.system}.hyprland "hyprctl"} dispatch dpms off";
        onResume = "${lib.getExe' inputs.hyprland.packages.${pkgs.system}.hyprland "hyprctl"} dispatch dpms on";
      }
      {
        timeout = 600;
        onTimeout = "${lib.getExe inputs.hyprlock.packages.${pkgs.system}.hyprlock}";
      }
    ];
  };

  programs.hyprlock = {
    enable = true;
    general = {
      no_fade_in = true;
    };
    backgrounds = [
      {
        path = "/home/viruz/arisu/wallpaper.png";
      }
    ];
  };

  home.packages = with pkgs; [
    wlr-randr
    wl-clipboard
    fuzzel
    wev
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    pavucontrol
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    grimblast
    feh
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  # TODO: move waybar to its own file
  programs.waybar = {
    enable = true;
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
