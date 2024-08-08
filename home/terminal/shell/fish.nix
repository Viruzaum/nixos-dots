{pkgs, ...}: let
  myAliases = {
    cat = "bat";
  };
in {
  programs.fish = {
    enable = true;
    shellAliases = myAliases;
    functions = {
      fish_greeting = "";
    };
  };

  home.packages = with pkgs; [
    disfetch
    bat
    eza
    bottom
    btop
    fd
    nix-prefetch-git
    ouch
    rm-improved
    moar
    ripgrep
    diskonaut
    du-dust
    nix-init
  ];
}
