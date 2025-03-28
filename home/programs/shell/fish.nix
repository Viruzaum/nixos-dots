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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };

  programs.starship = {
    enable = true;
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
    du-dust
    nix-init
  ];
}
