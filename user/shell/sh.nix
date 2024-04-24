{pkgs, ...}: let
  myAliases = {
    cat = "bat";
    #neofetch = "fastfetch -s title:separator:os:kernel:uptime:packages:shell:display:de:wm:theme:font:terminal:cpu:gpu:memory:swap:break:colors";
  };
in {
  imports = [
    ./helix.nix
    ./fastfetch.nix
  ];

  programs.fish = {
    enable = true;
    shellAliases = myAliases;
    functions = {
      fish_greeting = "fastfetch";
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
    diskonaut
    du-dust
    nix-init
  ];
}
