{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  requiredDeps = with pkgs; [
    config.wayland.windowManager.hyprland.package
    bash
    coreutils
    dart-sass
    gawk
    imagemagick
    procps
    ripgrep
    util-linux
  ];

  guiDeps = with pkgs; [
    gnome.gnome-control-center
    mission-center
    overskride
    wlogout
  ];

  dependencies = requiredDeps ++ guiDeps;

  cfg = config.programs.ags;
in {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  programs.ags.enable = true;

  systemd.user.services.ags = {
    Unit = {
      Description = "Aylur's Gtk Shell";
      PartOf = [
        "tray.target"
        "graphical-session.target"
      ];
    };
    Service = {
      Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
      ExecStart = "${cfg.package}/bin/ags";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  # home.file.".config/ags".source = config.lib.file.mkOutOfStoreSymlink ../ags;
  systemd.user.tmpfiles.rules = [
    "L /home/viruz/.dotfiles/home/services/ags - - - - /home/viruz/.config/ags"
  ];

  home.packages = dependencies;
}
