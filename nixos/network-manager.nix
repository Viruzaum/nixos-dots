{
  networking = {
    nameservers = ["9.9.9.9#dns.quad9.net"];
    networkmanager.enable = true;
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
    allowedUDPPorts = [12315];
    allowedTCPPorts = [12315];
  };
}
