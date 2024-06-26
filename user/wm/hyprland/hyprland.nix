{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../app/terminal/alacritty.nix
    ../../app/yazi/yazi.nix
    ../../app/notification/mako.nix
    ../waybar.nix

    inputs.hyprland.homeManagerModules.default
    inputs.hyprpaper.homeManagerModules.hyprpaper
    inputs.hypridle.homeManagerModules.hypridle
    inputs.hyprlock.homeManagerModules.hyprlock
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

          "$mod, return, exec, ${lib.getExe pkgs.alacritty}"
          "$mod,code:40, exec, ${lib.getExe pkgs.fuzzel}"
          "$mod,code:56, exec, ${lib.getExe pkgs.firefox}"
          ",pause,exec,${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

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
        ",print,exec,${lib.getExe pkgs.grimblast} --notify --freeze copysave area \"$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png\""
        "SHIFT,print,exec,${lib.getExe pkgs.grimblast} --notify copysave active \"$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png\""
        "CTRL,print,exec,${lib.getExe pkgs.grimblast} --notify copysave output \"$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png\""
      ];
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
        "deluged"
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

    '';
    xwayland.enable = true;
    systemd.enable = true;
  };

  services.hyprpaper = {
    enable = true;
    ipc = false;
    preloads = [
      config.stylix.image
    ];
    wallpapers = [
      ",${config.stylix.image}"
    ];
  };

  services.hypridle = {
    enable = true;
    lockCmd = lib.getExe inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    unlockCmd = "killall -USR1 hyprlock";
    beforeSleepCmd = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
    afterSleepCmd = "${lib.getExe' inputs.hyprland.packages.${pkgs.system}.hyprland "hyprctl"} dispatch dpms on";
    ignoreDbusInhibit = false;
    listeners = [
      {
        timeout = 300;
        onTimeout = "${lib.getExe pkgs.brightnessctl} -s set 0";
        onResume = "${lib.getExe pkgs.brightnessctl} -r";
      }
      {
        timeout = 630;
        onTimeout = "${lib.getExe' pkgs.deluge-gtk "deluge-console"} resume \"*\"";
        onResume = "${lib.getExe' pkgs.deluge-gtk "deluge-console"} pause \"*\"";
      }
      {
        timeout = 600;
        onTimeout = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
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
        path = config.stylix.image;
      }
    ];
  };

  home.packages = with pkgs; [
    wlr-randr
    wl-clipboard
    wev
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    pavucontrol
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    feh
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];
}
