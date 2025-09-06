{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv) isLinux;
in {
  xdg = {
    enable = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/..local/state";

    userDirs = mkIf isLinux {
      enable = true;
      createDirectories = true;

      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      desktop = "${config.home.homeDirectory}/desktop";
      videos = "${config.home.homeDirectory}/videos";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public/share";
      templates = "${config.home.homeDirectory}/public/templates";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
        XDG_DEV_DIR = "${config.home.homeDirectory}/dev";
      };
    };
  };
}
