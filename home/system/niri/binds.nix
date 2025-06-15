{
  config,
  pkgs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
    playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
  in {
    "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

    "XF86AudioPlay".action = playerctl "play-pause";
    "XF86AudioStop".action = playerctl "pause";
    "XF86AudioPrev".action = playerctl "previous";
    "XF86AudioNext".action = playerctl "next";

    "Pause".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

    "XF86AudioRaiseVolume".action = set-volume "5%+";
    "XF86AudioLowerVolume".action = set-volume "5%-";

    "Print".action = screenshot;
    "Ctrl+Print".action.screenshot-screen = [];
    "Shift+Print".action = screenshot-window;
    "Mod+D".action = spawn "fuzzel";
    "Mod+B".action = spawn "zen";
    "Mod+Return".action = spawn "kitty";
    "Mod+R".action = switch-preset-column-width;
    "Mod+Shift+P".action = power-off-monitors;
    "Mod+I".action = show-hotkey-overlay;
    "Mod+Shift+E".action = quit;

    # "Mod+Insert".action = set-dynamic-cast-window;
    # "Mod+Shift+Insert".action = set-dynamic-cast-monitor;
    # "Mod+Delete".action = clear-dynamic-cast-target;

    "Mod+Q".action = close-window;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+Space".action = toggle-window-floating;
    "Mod+W".action = toggle-column-tabbed-display;

    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;
    # "Mod+C".action = center-visible-columns;
    "Mod+Tab".action = switch-focus-between-floating-and-tiling;

    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Plus".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Plus".action = set-window-height "+10%";

    "Mod+H".action = focus-column-left;
    "Mod+L".action = focus-column-right;
    "Mod+J".action = focus-window-or-workspace-down;
    "Mod+K".action = focus-window-or-workspace-up;
    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Down".action = focus-workspace-down;
    "Mod+Up".action = focus-workspace-up;

    "Mod+Ctrl+H".action = move-column-left;
    "Mod+Ctrl+L".action = move-column-right;
    "Mod+Ctrl+K".action = move-column-to-workspace-up;
    "Mod+Ctrl+J".action = move-column-to-workspace-down;

    "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
    "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;

    "Mod+WheelScrollDown" = {
      action = focus-workspace-down;
      cooldown-ms = 150;
    };
    "Mod+WheelScrollUp" = {
      action = focus-workspace-up;
      cooldown-ms = 150;
    };
    "Mod+Ctrl+WheelScrollDown" = {
      action = move-window-to-workspace-down;
      cooldown-ms = 150;
    };
    "Mod+Ctrl+WheelScrollUp" = {
      action = move-window-to-workspace-up;
      cooldown-ms = 150;
    };
    "Mod+Shift+WheelScrollDown" = {
      action = focus-column-right;
      cooldown-ms = 150;
    };
    "Mod+Shift+WheelScrollUp" = {
      action = focus-column-left;
      cooldown-ms = 150;
    };

    "Mod+WheelScrollRight".action = focus-column-right;
    "Mod+WheelScrollLeft".action = focus-column-left;
    "Mod+Ctrl+WheelScrollRight".action = move-column-right;
    "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

    "Mod+1".action = focus-workspace 1;
    "Mod+2".action = focus-workspace 2;
    "Mod+3".action = focus-workspace 3;
    "Mod+4".action = focus-workspace 4;
    "Mod+5".action = focus-workspace 5;
    "Mod+6".action = focus-workspace 6;
    "Mod+7".action = focus-workspace 7;
    "Mod+8".action = focus-workspace 8;
    "Mod+9".action = focus-workspace 9;

    "Mod+Ctrl+1".action.move-window-to-workspace = 1;
    "Mod+Ctrl+2".action.move-window-to-workspace = 2;
    "Mod+Ctrl+3".action.move-window-to-workspace = 3;
    "Mod+Ctrl+4".action.move-window-to-workspace = 4;
    "Mod+Ctrl+5".action.move-window-to-workspace = 5;
    "Mod+Ctrl+6".action.move-window-to-workspace = 6;
    "Mod+Ctrl+7".action.move-window-to-workspace = 7;
    "Mod+Ctrl+8".action.move-window-to-workspace = 8;
    "Mod+Ctrl+9".action.move-window-to-workspace = 9;
  };
}
