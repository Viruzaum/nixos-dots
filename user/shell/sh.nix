{pkgs, ...}: let
  myAliases = {
    cat = "bat";
    neofetch = "disfetch";
  };
in {
  programs.fish = {
    enable = true;
    shellAliases = myAliases;
    functions = {
      fish_greeting = "neofetch";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    disfetch
    bat
    eza
    bottom
    fd
    nix-prefetch-git
    ouch
    rm-improved
    moar
    ripgrep
  ];
}
