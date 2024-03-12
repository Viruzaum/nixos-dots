{ config, lib, pkgs, ... }:

{
  stylix.image = pkgs.fetchurl {
    url = "https://static.zerochan.net/Tendou.Alice.full.3631666.png";
    hash = "sha256-gTf08qQa7LQYq69xSGkmOR74adW7rZaBuXf4g+Kx2Hc=";
  };
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  #stylix.targets.waybar.enable = false;
  stylix.fonts = {
    monospace = {
      name = "Intel One Mono";
      package = pkgs.intel-one-mono;
    };
    serif = {
      name = "Intel One Mono";
      package = pkgs.intel-one-mono;
    };
    sansSerif = {
      name = "Intel One Mono";
      package = pkgs.intel-one-mono;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji-blob-bin;
    };
    sizes = {
      terminal = 12;
      applications = 12;
      popups = 12;
      desktop = 12;
    };
  };

  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "Breeze";
  };
}
