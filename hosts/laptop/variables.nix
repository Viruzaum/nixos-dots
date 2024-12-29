{config, ...}: {
  imports = [../../nixos/variables-config.nix];

  config.var = {
    hostname = "mimi";
    username = "viruz";
    configDirectory =
      "/home/"
      + config.var.username
      + "/.dotfiles"; # The path of the nixos configuration directory

    keyboardLayout = "br";

    location = "Mococa";
    timeZone = "America/Sao_Paulo";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "ja_JP.UTF-8";

    git = {
      username = "Viruzaum";
      email = "gustavomelati@hotmail.com";
    };

    autoUpgrade = true;
    autoGarbageCollector = true;

    theme = import ../../themes/var/var.nix;
  };
}
