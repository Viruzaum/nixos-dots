{config, ...}: {
  services.syncthing = {
    enable = true;
    user = config.var.username;
  };
}
