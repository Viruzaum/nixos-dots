{pkgs, ...}: {
  imports = [
    ./fastfetch.nix
    ./git.nix
    ./yazi
  ];
  home.packages = with pkgs; [
    libgtop
    gitoxide
    zed-editor
  ];
}
