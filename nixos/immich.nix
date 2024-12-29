{config, ...}: {
  services.immich = {
    enable = true;
    user = config.var.username;
    openFirewall = true;
  };
}
