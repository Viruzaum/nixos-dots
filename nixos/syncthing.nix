{config, ...}: {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    # user = config.var.username;
    # configDir = "/home/" + config.var.username + "/.config/syncthing";
  };
}
