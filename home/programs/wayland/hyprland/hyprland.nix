{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  grimblast = inputs.hypr-contrib.packages.${pkgs.system}.grimblast;
  runOnce = program: "pgrep ${program} || ${program}";
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
    ];
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, code:24, killactive"

          "$mod SHIFT, code:24, exit"
          "$mod, code:41, fullscreen"
          "$mod, space, togglefloating"
          "$mod, code:33, pseudo"
          "$mod, code:55, togglesplit"
          "$mod, code:53, pin"

          "$mod, return, exec, ${lib.getExe pkgs.kitty}"
          "$mod,code:40, exec, ${lib.getExe pkgs.fuzzel}"
          "$mod,code:56, exec, ${lib.getExe inputs.zen-browser.packages.${pkgs.system}.generic}"
          ",pause,exec,${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          "$mod, code:32, exec, ${runOnce "wl-ocr"}"

          "$mod, code:43,movefocus,l"
          "$mod, code:46,movefocus,r"
          "$mod, code:45,movefocus,u"
          "$mod, code:44,movefocus,d"

          "$mod SHIFT, code:43, swapwindow, l"
          "$mod SHIFT, code:46, swapwindow, r"
          "$mod SHIFT, code:45, swapwindow, u"
          "$mod SHIFT, code:44, swapwindow, d"
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
      bindl = [
        ",print,exec,${lib.getExe grimblast} --notify --freeze copysave area \"$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png\""
        "SHIFT,print,exec,${lib.getExe grimblast} --notify copysave active \"$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png\""
        "CTRL,print,exec,${lib.getExe grimblast} --notify copysave output \"$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png\""
      ];
      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];
      env = [
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE,32"
        "QT_QPA_PLATFORM,wayland;xcb"
        "XDG_SESSION_TYPE,wayland"
        "AQ_NO_ATOMIC,1"
      ];
      monitor = ",preferred,auto,auto";
      general = {
        layout = "dwindle";
        border_size = 2;
        gaps_in = 0;
        gaps_out = 0;

        allow_tearing = true;
      };
      cursor = {
        inactive_timeout = 30;
        no_warps = false;
      };
      exec-once = [
        "${lib.getExe pkgs.hyprpanel}"
        "fcitx5 -d"
        "nicotine-plus -s"
        "vesktop"
        "deluged"
        "~/.local/bin/jellyfin-rpc"
      ];
      input = {
        kb_layout = "br, br-workman";
        kb_options = "caps:none, grp:alt_space_toggle";
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
        "workspace 2,class:^(zen.*)$"
        "immediate,class:^(osu!)$"
        "immediate,class:^(tf_linux64)$"
        "immediate,class:^(Minecraft*)$"
        "immediate,class:^(hl2_linux)$"
      ];
      layerrule = [
        "blur,bar"
      ];
    };
    xwayland.enable = true;
    systemd.enable = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = false;
      preload = [
        config.theme.wallpaper
      ];
      wallpaper = [
        ",${config.theme.wallpaper}"
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = lib.getExe inputs.hyprlock.packages.${pkgs.system}.hyprlock;
        unlock_cmd = "killall -USR1 hyprlock";
        before_sleep_cmd = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
        after_sleep_cmd = "${lib.getExe' inputs.hyprland.packages.${pkgs.system}.hyprland "hyprctl"} dispatch dpms on";
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

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = true;
      };
      background = [
        {
          path = config.theme.wallpaper;
        }
      ];
      input-field = {
        monitor = "";
        size = "200, 50";
        outline_thickness = 3;
        dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = false;
        dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
        outer_color = "rgb(151515)";
        inner_color = "rgb(200, 200, 200)";
        font_color = "rgb(10, 10, 10)";
        fade_on_empty = true;
        fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
        placeholder_text = "<i>Input Password...</i>"; # Text rendered in the input box when it's empty.
        hide_input = false;
        rounding = -1; # -1 means complete rounding (circle/oval)
        check_color = "rgb(204, 136, 34)";
        fail_color = "rgb(204, 34, 34)"; # if authentication failed, changes outer_color and fail message color
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
        fail_timeout = 2000; # milliseconds before fail_text and fail_color disappears
        fail_transition = 300; # transition time in ms between normal outer_color and fail_color
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1; # when both locks are active. -1 means don't change outer color (same for above)
        invert_numlock = false; # change color if numlock is off
        swap_font_color = false; # see below

        position = "0, -20";
        halign = "center";
        valign = "center";
      };
    };
  };
}
