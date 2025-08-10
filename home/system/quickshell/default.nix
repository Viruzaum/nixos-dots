{
  pkgs,
  inputs,
  ...
}: {
  home.packages =
    [
      inputs.quickshell.packages."${pkgs.system}".default
    ]
    ++ (with pkgs; [
      kdePackages.qt5compat
      material-symbols
      nerd-fonts.jetbrains-mono
      ibm-plex
      papirus-icon-theme
      material-icons
    ]);
}
