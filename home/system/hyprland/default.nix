{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (inputs.hypr-contrib.packages.${pkgs.system}) grimblast;
  inherit (inputs.pyprland.packages.${pkgs.system}) pyprland;
  runOnce = program: "pgrep ${program} || ${program}";
  jq = lib.getExe pkgs.jq;
  zen-browser = lib.getExe inputs.zen-browser.packages.${pkgs.system}.zen-browser;

  inherit (config.var.theme) border-size;
  inherit (config.var.theme) gaps-in;
  inherit (config.var.theme) gaps-out;
  inherit (config.var.theme) active-opacity;
  inherit (config.var.theme) inactive-opacity;
  inherit (config.var.theme) rounding;
  inherit (config.var.theme) blur;
  inherit (config.var) keyboardLayout;
in {
  imports = [./polkitagent.nix];

  home.packages = with pkgs; [
    # qt5.qtwayland
    # qt6.qtwayland
    # libsForQt5.qt5ct
    # qt6ct
    hyprpicker
    wl-clipboard
    wl-screenrec
    wlr-randr
    wev
    brightnessctl
    wl-kbptr
    wlrctl
    resources
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    # package = inputs.hyprland.packages."${pkgs.system}".hyprland;

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
          "$mod, code:58, exec, loginctl lock-session"

          "$mod, return, exec, ${lib.getExe pkgs.kitty}"
          # "$mod,code:40, exec, ${lib.getExe pkgs.fuzzel}"
          "$mod,code:40, exec, ${lib.getExe inputs.anyrun.packages.${pkgs.system}.anyrun}"
          "$mod,code:56, exec, ${zen-browser}"
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

          "$mod SHIFT, code:59, movecurrentworkspacetomonitor, -1"
          "$mod SHIFT, code:60, movecurrentworkspacetomonitor, +1"

          "$mod, code:52, exec, ${lib.getExe' pyprland "pypr"} zoom"
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
        ",print,exec,${lib.getExe grimblast} --notify --freeze copysave area \"$XDG_SCREENSHOTS_DIR/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | ${jq} -r .class).png\""
        "SHIFT,print,exec,${lib.getExe grimblast} --notify copysave active \"$XDG_SCREENSHOTS_DIR/$(date +'%F_%H_%M_%S')_$(hyprctl activewindow -j | ${jq} -r .class).png\""
        "CTRL,print,exec,${lib.getExe grimblast} --notify copysave output \"$XDG_SCREENSHOTS_DIR/$(date +'%F_%H_%M_%S')_$(hyprctl monitors -j | ${jq} -r \".[$(hyprctl activewindow -j | ${jq} -r .monitor)].name\").png\""
        "ALT,print,exec,${lib.getExe grimblast} --notify copysave screen \"$XDG_SCREENSHOTS_DIR/$(date +'%F_%H_%M_%S').png\""
      ];
      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];
      env = [
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,gtk2"
        "XDG_SESSION_TYPE,wayland"
        "NIXOS_OZONE_WL,1"
        "SDL_VIDEODRIVER,wayland"
      ];
      monitor = ",preferred,auto,1";
      general = {
        layout = "dwindle";
        border_size = border-size;
        gaps_in = gaps-in;
        gaps_out = gaps-out;

        allow_tearing = true;
      };
      cursor = {
        inactive_timeout = 30;
        no_warps = false;
      };
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME"
        "fcitx5 -d"
        "nicotine-plus -s"
        "vesktop"
        "deluged"
        (lib.getExe pkgs.jellyfin-rpc)
        (lib.getExe' pyprland "pypr")
      ];
      input = {
        kb_layout = "${keyboardLayout}";
        kb_options = "caps:escape";
        accel_profile = "flat";
        follow_mouse = 1;
        sensitivity = 0;
      };
      misc = {
        vfr = true;
        middle_click_paste = false;
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
    extraConfig = ''
      # Cursor submap (similar to the Mouse mode in Sway)
      submap=cursor

      # Jump cursor to a position
      bind=,a,exec,hyprctl dispatch submap reset && wl-kbptr && hyprctl dispatch submap cursor

      # Cursor movement
      binde=,j,exec,wlrctl pointer move 0 10
      binde=,k,exec,wlrctl pointer move 0 -10
      binde=,l,exec,wlrctl pointer move 10 0
      binde=,h,exec,wlrctl pointer move -10 0

      # Left button
      bind=,s,exec,wlrctl pointer click left
      # Middle button
      bind=,d,exec,wlrctl pointer click middle
      # Right button
      bind=,f,exec,wlrctl pointer click right

      # Scroll up and down
      binde=,e,exec,wlrctl pointer scroll 10 0
      binde=,r,exec,wlrctl pointer scroll -10 0

      # Scroll left and right
      binde=,t,exec,wlrctl pointer scroll 0 -10
      binde=,g,exec,wlrctl pointer scroll 0 10

      # Exit cursor submap
      # If you do not use cursor timeout or cursor:hide_on_key_press, you can delete its respective cals
      bind=,escape,exec,hyprctl keyword cursor:inactive_timeout 3; hyprctl keyword cursor:hide_on_key_press true; hyprctl dispatch submap reset

      submap = reset

      # Entrypoint
      # If you do not use cursor timeout or cursor:hide_on_key_press, you can delete its respective cals
      bind=$mod,g,exec,hyprctl keyword cursor:inactive_timeout 0; hyprctl keyword cursor:hide_on_key_press false; hyprctl dispatch submap cursor
    '';
  };
}
