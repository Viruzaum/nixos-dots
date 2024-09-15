{pkgs, ...}: let
  background = pkgs.fetchurl {
    url = "https://static.zerochan.net/Tendou.Alice.full.3631666.png";
    hash = "sha256-gTf08qQa7LQYq69xSGkmOR74adW7rZaBuXf4g+Kx2Hc=";
  };
in {
  imports = [
    ./pipewire.nix
    ./gnome-keyring.nix
  ];

  environment.systemPackages = with pkgs; [
    (sddm-chili-theme.override {
      themeConfig = {
        background = background;
      };
    })
  ];

  # Configure xwayland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "chili";
  };
}
