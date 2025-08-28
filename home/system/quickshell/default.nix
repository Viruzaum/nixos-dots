{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) quickshell;
in {
  home.packages = with pkgs; [
    quickshell.packages."${pkgs.system}".default
    qt6.qt5compat
    material-symbols
    nerd-fonts.jetbrains-mono
    ibm-plex
    papirus-icon-theme
    material-icons
  ];

  xdg.configFile."quickshell/meow".source = ./meow;
}
