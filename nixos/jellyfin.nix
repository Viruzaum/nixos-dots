{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "viruz";
  };

  environment.systemPackages = [
    # pkgs.jellyfin-mpv-shim
  ];
}
