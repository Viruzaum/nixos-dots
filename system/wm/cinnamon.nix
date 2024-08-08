{...}: {
  imports = [
    ./pipewire.nix
  ];
  services.xserver.desktopManager.cinnamon.enable = true;
  hardware.pulseaudio.enable = false;
}
