{...}: {
  imports = [
    ./pipewire.nix
  ];
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.enable = true;
  hardware.pulseaudio.enable = false;
}
