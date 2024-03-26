{authorizedKeys ? [], ...}: {
  services.openssh = {
    enable = true;
    #openFirewall = true;
    settings.PasswordAuthentication = false;
  };

  users.users.viruz.openssh.authorizedKeys.keys = authorizedKeys;
}
