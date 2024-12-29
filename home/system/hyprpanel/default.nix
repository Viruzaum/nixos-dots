# Hyprpanel is the bar on top of the screen
# Display informations like workspaces, battery, wifi, ...
{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  inherit (config.var.theme.bar) transparentButtons;
  hyprpanel = inputs.hyprpanel.packages.${pkgs.system}.default;

  accent = "#${config.lib.stylix.colors.base0D}";
  accent-alt = "#${config.lib.stylix.colors.base03}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  foreground = "#${config.lib.stylix.colors.base05}";
  font = "${config.stylix.fonts.serif.name}";
  fontSize = "${toString config.stylix.fonts.sizes.desktop}";

  inherit (config.var.theme) rounding;
  inherit (config.var.theme) border-size;

  inherit (config.var.theme) gaps-out;
  inherit (config.var.theme) gaps-in;

  inherit (config.var.theme.bar) floating;
  inherit (config.var.theme.bar) transparent;
  inherit (config.var.theme.bar) position;

  inherit (config.var) location;
  inherit (config.var) username;
in {
  wayland.windowManager.hyprland.settings.exec-once = [(lib.getExe hyprpanel)];

  home.packages = [hyprpanel pkgs.libnotify];

  home.file.".cache/ags/hyprpanel/options.json" = {
    text =
      # json
      ''
        {
          "bar.layouts": {
            "0": {
              "left": [
                "dashboard",
                "workspaces",
                "windowtitle"
              ],
              "middle": [
                "media"
              ],
              "right": [
                "cpu",
                "ram",
                "systray",
                "volume",
                "bluetooth",
                "network",
                "clock",
                "notifications"
              ]
            },
            "1": {
              "left": [
                "dashboard",
                "workspaces",
                "windowtitle"
              ],
              "middle": [
                "media"
              ],
              "right": [
                "cpu",
                "ram",
                "clock",
                "notifications"
              ]
            }
          },
          "theme.font.name": "${font}",
          "theme.font.size": "${fontSize}px",
          "theme.bar.outer_spacing": "${
          if floating && transparent
          then "0"
          else "8"
        }px",
          "theme.bar.buttons.y_margins": "${
          if floating && transparent
          then "0"
          else "8"
        }px",
          "theme.bar.buttons.spacing": "0.3em",
          "theme.bar.buttons.radius": "${
          if transparent
          then toString rounding
          else toString (rounding - 8)
        }px",
          "theme.bar.floating": ${
          if floating
          then "true"
          else "false"
        },
          "theme.bar.buttons.padding_x": "0.8rem",
          "theme.bar.buttons.padding_y": "0.4rem",

          "theme.bar.buttons.workspaces.hover": "${accent-alt}",
          "theme.bar.buttons.workspaces.active": "${accent}",
          "theme.bar.buttons.workspaces.available": "${background}",

          "theme.bar.margin_top": "${
          if position == "top"
          then toString (gaps-in * 2)
          else "0"
        }px",
          "theme.bar.margin_bottom": "${
          if position == "top"
          then "0"
          else toString (gaps-in * 2)
        }px",
          "theme.bar.margin_sides": "${toString gaps-out}px",
          "theme.bar.border_radius": "${toString rounding}px",

          "bar.launcher.icon": "",
          "theme.bar.transparent": ${
          if transparent
          then "true"
          else "false"
        },
          "bar.workspaces.show_numbered": false,
          "bar.workspaces.workspaces": 5,
          "bar.workspaces.monitorSpecific": true,
          "bar.workspaces.hideUnoccupied": false,
          "bar.windowtitle.label": true,
          "bar.volume.label": false,
          "bar.network.truncation_size": 12,
          "bar.bluetooth.label": false,
          "bar.clock.format": "%a %b %d  %H:%M %p",
          "bar.notifications.show_total": true,
          "theme.notification.border_radius": "${toString rounding}px",
          "theme.osd.enable": true,
          "theme.osd.orientation": "vertical",
          "theme.osd.location": "left",
          "theme.osd.radius": "${toString rounding}px",
          "theme.osd.margins": "0px 0px 0px 10px",
          "theme.osd.muted_zero": true,
          "menus.clock.weather.location": "${location}",
          "menus.clock.weather.key": "",
          "menus.clock.weather.unit": "metric",
          "menus.dashboard.powermenu.avatar.image": "/home/${username}/.profile_picture.png",
          "menus.dashboard.powermenu.confirmation": false,

          "menus.dashboard.shortcuts.left.shortcut1.icon": "",
          "menus.dashboard.shortcuts.left.shortcut1.command": "qutebrowser",
          "menus.dashboard.shortcuts.left.shortcut1.tooltip": "Qutebrowser",
          "menus.dashboard.shortcuts.left.shortcut2.icon": "󰅶",
          "menus.dashboard.shortcuts.left.shortcut2.command": "caffeine",
          "menus.dashboard.shortcuts.left.shortcut2.tooltip": "Caffeine",
          "menus.dashboard.shortcuts.left.shortcut3.icon": "󰖔",
          "menus.dashboard.shortcuts.left.shortcut3.command": "night-shift",
          "menus.dashboard.shortcuts.left.shortcut3.tooltip": "Night-shift",
          "menus.dashboard.shortcuts.left.shortcut4.icon": "",
          "menus.dashboard.shortcuts.left.shortcut4.command": "menu",
          "menus.dashboard.shortcuts.left.shortcut4.tooltip": "Search Apps",
          "menus.dashboard.shortcuts.right.shortcut1.icon": "",
          "menus.dashboard.shortcuts.right.shortcut1.command": "hyprpicker -a",
          "menus.dashboard.shortcuts.right.shortcut1.tooltip": "Color Picker",
          "menus.dashboard.shortcuts.right.shortcut3.icon": "󰄀",
          "menus.dashboard.shortcuts.right.shortcut3.command": "screenshot region swappy",
          "menus.dashboard.shortcuts.right.shortcut3.tooltip": "Screenshot",

          "menus.dashboard.directories.left.directory1.label": "󰉍 Downloads",
          "menus.dashboard.directories.left.directory1.command": "bash -c \"thunar $HOME/Downloads/\"",
          "menus.dashboard.directories.left.directory2.label": "󰉏 Pictures",
          "menus.dashboard.directories.left.directory2.command": "bash -c \"thunar $HOME/Pictures/\"",
          "menus.dashboard.directories.left.directory3.label": "󱧶 Documents",
          "menus.dashboard.directories.left.directory3.command": "bash -c \"thunar $HOME/Documents/\"",
          "menus.dashboard.directories.right.directory1.label": "󱂵 Home",
          "menus.dashboard.directories.right.directory1.command": "bash -c \"thunar $HOME/\"",
          "menus.dashboard.directories.right.directory2.label": "󰚝 Projects",
          "menus.dashboard.directories.right.directory2.command": "bash -c \"thunar $HOME/dev/\"",
          "menus.dashboard.directories.right.directory3.label": " Config",
          "menus.dashboard.directories.right.directory3.command": "bash -c \"thunar $HOME/.config/\"",


          "theme.bar.menus.monochrome": true,
          "wallpaper.enable": false,
          "theme.bar.menus.background": "${background}",
          "theme.bar.menus.cards": "${background-alt}",
          "theme.bar.menus.card_radius": "${toString rounding}px",
          "theme.bar.menus.label": "${foreground}",
          "theme.bar.menus.text": "${foreground}",
          "theme.bar.menus.border.size": "${toString border-size}px",
          "theme.bar.menus.border.color": "${accent}",
          "theme.bar.menus.border.radius": "${toString rounding}px",
          "theme.bar.menus.popover.text": "${foreground}",
          "theme.bar.menus.popover.background": "${background-alt}",
          "theme.bar.menus.listitems.active": "${accent}",
          "theme.bar.menus.icons.active": "${accent}",
          "theme.bar.menus.switch.enabled":"${accent}",
          "theme.bar.menus.check_radio_button.active": "${accent}",
          "theme.bar.menus.buttons.default": "${accent}",
          "theme.bar.menus.buttons.active": "${accent}",
          "theme.bar.menus.iconbuttons.active": "${accent}",
          "theme.bar.menus.progressbar.foreground": "${accent}",
          "theme.bar.menus.slider.primary": "${accent}",
          "theme.bar.menus.tooltip.background": "${background-alt}",
          "theme.bar.menus.tooltip.text": "${foreground}",
          "theme.bar.menus.dropdownmenu.background":"${background-alt}",
          "theme.bar.menus.dropdownmenu.text": "${foreground}",
          "theme.bar.background": "${
          background
          + (
            if transparentButtons
            then "00"
            else ""
          )
        }",
          "theme.bar.buttons.style": "default",
          "theme.bar.buttons.monochrome": true,
          "theme.bar.buttons.text": "${foreground}",
          "theme.bar.buttons.background": "${
          (
            if transparent
            then background
            else background-alt
          )
          + (
            if transparentButtons
            then "E0"
            else ""
          )
        }",
          "theme.bar.buttons.icon": "${accent}",
          "theme.bar.buttons.notifications.background": "${background-alt}",
          "theme.bar.buttons.hover": "${background}",
          "theme.bar.buttons.notifications.hover": "${background}",
          "theme.bar.buttons.notifications.total": "${accent}",
          "theme.bar.buttons.notifications.icon": "${accent}",
          "theme.notification.background": "${background-alt}",
          "theme.notification.actions.background": "${accent}",
          "theme.notification.actions.text": "${foreground}",
          "theme.notification.label": "${accent}",
          "theme.notification.border": "${background-alt}",
          "theme.notification.text": "${foreground}",
          "theme.notification.labelicon": "${accent}",
          "theme.osd.bar_color": "${accent}",
          "theme.osd.bar_overflow_color": "${accent-alt}",
          "theme.osd.icon": "${background}",
          "theme.osd.icon_container": "${accent}",
          "theme.osd.label": "${accent}",
          "theme.osd.bar_container": "${background-alt}",
          "theme.bar.menus.menu.media.background.color": "${background-alt}",
          "theme.bar.menus.menu.media.card.color": "${background-alt}",
          "theme.bar.menus.menu.media.card.tint": 90,
          "bar.customModules.updates.pollingInterval": 1440000,
          "bar.media.show_active_only": true,
          "bar.media.truncation": false,
          "theme.bar.location": "${position}"
        }
      '';
  };
}
