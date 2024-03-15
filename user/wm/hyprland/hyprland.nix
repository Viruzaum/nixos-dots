{pkgs, ...}: {
  imports = [
    ../../app/terminal/alacritty.nix
    ../../app/yazi/yazi.nix
    ../../app/notification/mako.nix
  ];

  #xdg.portal = {
  #enable = true;
  #extraPortals = with pkgs; [xdg-desktop-portal-hyprland xdg-desktop-portal-gtk];
  #config = {
  #hyprland = {
  #default = ["hyprland"];
  # this doesnt work
  #"org.freedesktop.portal.FileChooser" = ["gtk"];
  #};
  #};
  #};

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [];
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, return, exec, alacritty"
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
      monitor = ",preferred,auto,auto";
      general = {
	layout = "dwindle";
	cursor_inactive_timeout = 30;
	border_size = 2;
	no_cursor_warps = false;
	gaps_in = 0;
	gaps_out = 0;
	#"col.active_border" = "rgba(cba6f7ff) rgba(f5c2e7ff) 45deg";
        #"col.inactive_border" = "rgba(1e1e2eff)";

        allow_tearing = true;
      };
    };
    extraConfig = ''
      #monitor = ,preferred,auto,auto

      exec-once = waybar
      exec-once = hyprpaper
      exec-once = hypridle
      exec-once = fcitx5 -d

      env = QT_QPA_PLATFORMTHEME,qt5ct
      env = QT_QPA_PLATFORM,wayland;xcb
      env = XDG_SESSION_TYPE,wayland

      env = WLR_DRM_NO_ATOMIC,1

      #general {
        #layout = dwindle
        #cursor_inactive_timeout = 30
        #border_size = 2
        #no_cursor_warps = false
        #gaps_in = 0
        #gaps_out = 0

        #col.active_border = rgba(cba6f7ff) rgba(f5c2e7ff) 45deg
        #col.inactive_border = rgba(1e1e2eff)

        #allow_tearing = true
      #}

      input {
        kb_layout = br, br-workman
        kb_options = caps:none, grp:alt_shift_toggle

        accel_profile = flat

        follow_mouse = 1

        sensitivity = 0
      }

      misc {
        vfr = true
      }

      $mainMod = SUPER
      #bind = $mainMod,return,exec,alacritty
      bind = $mainMod,code:24,killactive
      bind = $mainMod SHIFT,code:24,exit
      bind = $mainMod,code:41,fullscreen
      bind = $mainMod,space,togglefloating
      bind = $mainMod,code:33,pseudo
      bind = $mainMod,code:55,togglesplit

      bind = $mainMod,code:40,exec,fuzzel
      bind = $mainMod,code:56,exec,firefox
      bind = $mainMod,code:25,exec,killall -SIGUSR2 waybar
      bind = ,pause,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

      #bind = ,print,exec,hyprshot -F -f 0 -m region -o $HOME/Pictures/screenshots/ -f "$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png"
      #bind = SHIFT,print,exec,hyprshot -t 0 -m window -c -o $HOME/Pictures/screenshots/ -f "$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png"
      #bind = CTRL,print,exec,hyprshot -t 0 -m output -c -o $HOME/Pictures/screenshots/ -f "$(daate +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png"

      bind = ,print,exec,grimblast --notify --freeze copysave area "$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png"
      bind = SHIFT,print,exec,grimblast --notify copysave active "$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png"
      bind = CTRL,print,exec,grimblast --notify copysave output "$HOME/Pictures/screenshots/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | jq -r .class).png"

      bind = $mainMod,code:43,movefocus,l
      bind = $mainMod,code:46,movefocus,r
      bind = $mainMod,code:45,movefocus,u
      bind = $mainMod,code:44,movefocus,d

      bindm = $mainMod,mouse:272,movewindow
      bindm = $mainMod,mouse:273,resizewindow

      windowrulev2 = suppressevent maximize, class:.*
      windowrulev2 = float,title:^(Picture-in-Picture)$
      windowrulev2 = pin,title:^(Picture-in-Picture)$
      windowrulev2 = keepaspectratio,title:^(Picture-in-Picture)$
      windowrulev2 = keepaspectratio,class:^(mpv)$
      windowrulev2 = workspace 3,class:^(vesktop)$
      windowrulev2 = workspace 2,class:^(firefox)$
      windowrulev2 = immediate,class:^(osu!.exe)$
      windowrulev2 = immediate,class:^(osu!)$
      windowrulev2 = immediate,class:^(Team Fortress 2 - OpenGL)$
    '';

    xwayland.enable = true;
    systemd.enable = true;
  };

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /home/viruz/arisu/wallpaper.png
    wallpaper = ,/home/viruz/arisu/wallpaper.png
    splash = false
    ipc = false
  '';

  home.file.".config/hypr/hypridle.conf".text = ''
    general {}

    listener {
      timeout = 300
      on-timeout = hyprctl dispatch dpms off
      on-resume = hyprctl dispatch dpms on
    }

    listener {
      timeout = 600
      on-timeout = hyprlock
    }
  '';

  home.file.".config/hypr/hyprlock.conf".text = ''
    general {
      disable_loading_bar = false
      hide_cursor = true
      grace = 0
      no_fade_in = false
    }

    background {
      monitor =
      path = /home/viruz/arisu/wallpaper.png
    }

    input-filed {
      monitor =
      size = 200, 50
      outline_thickness = 0
      dots_size = 0.33
      dots_spacing = 0.15
      dots_center = true
      outer_color = rgba(00000000)
      inner_color = rgba(00000000)
      font_color = rgb(10, 10, 10)
      fade_on_empty = true
      placeholder_text =
      hide_input = true

      position = 0, 0
      halign = center
      valign = center
    }
  '';

  home.packages = with pkgs; [
    wlr-randr
    wl-clipboard
    fuzzel
    wev
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    pavucontrol
    hyprpaper
    hypridle
    hyprlock
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
