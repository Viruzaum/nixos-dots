{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./browsers/firefox.nix
    ./media
    ./games/mangohud.nix
    ./gtk.nix
    ./qt.nix
  ];

  home.packages = with pkgs; [
    mission-center
    jetbrains.idea-community
    libreoffice
    modrinth-app
    inputs.zen-browser.packages."${pkgs.system}".generic
  ];
}
