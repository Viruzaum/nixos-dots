{pkgs, ...}: {
  imports = [
    ./browsers/firefox.nix
    ./media
    ./gtk.nix
    ./qt.nix
  ];

  home.packages = with pkgs; [
    mission-center
    jetbrains.idea-community
    inputs.zen-browser.packages."${pkgs.system}".generic
  ];
}
