{
  inputs,
  config,
  self,
  lib,
  ...
}: let
  inherit (lib) mapAttrs mkForce;
in {
  imports = [
    ../../nixos/audio.nix
    ../../nixos/bluetooth.nix
    # ../../nixos/cosmic.nix
    # ../../nixos/deluge.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/intel.nix
    ../../nixos/network-manager.nix
    ../../nixos/jellyfin.nix
    # ../../nixos/niri.nix
    ../../nixos/nix.nix
    # ../../nixos/printer.nix
    ../../nixos/power.nix
    ../../nixos/openssh.nix
    # ../../nixos/ratbag.nix
    ../../nixos/sonarr.nix
    # ../../nixos/steam.nix
    # ../../nixos/sunshine.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/timezone.nix
    ../../nixos/tailscale.nix
    ../../nixos/users.nix
    ../../nixos/nix-ld.nix
    ../../nixos/utils.nix
    # ../../nixos/xdg-portal.nix
    # ../../nixos/otd.nix
    ../../nixos/variables-config.nix
    # ../../nixos/waydroid.nix
    ../../nixos/zram.nix

    ../../themes/stylix/stylix.nix

    ./hardware-configuration.nix
    ./variables.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    inputs.chaotic.nixosModules.default
    inputs.kuroneko.nixosModules.default
  ];

  boot.extraModulePackages = [config.boot.kernelPackages.broadcom_sta];

  security.sudo.wheelNeedsPassword = false;

  users.users.viruz.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII0Rif5a4pyP54S5L1ELnoBWgTL1ipjqb43rhCWCcz3z viruz@yun"
  ];

  nixpkgs.config.allowInsecurePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "broadcom-sta" # aka “wl”
    ];

  services.kuroneko = {
    enable = true;
    envFile = config.age.secrets.kuroneko.path;
    dataDir = "/home/viruz/kuroneko";
  };

  services.xserver.enable = mkForce false;

  # print the URL instead on servers
  environment.variables.BROWSER = "echo";

  # we don't need fonts on a server
  # since there are no fonts to be configured outside the console
  fonts = mapAttrs (_: mkForce) {
    packages = [];
    fontDir.enable = false;
    fontconfig.enable = false;
  };

  # a headless system should not mount any removable media without explicit
  # user action
  services.udisks2.enable = lib.modules.mkForce false;

  xdg = mapAttrs (_: mkForce) {
    sounds.enable = false;
    mime.enable = false;
    menus.enable = false;
    icons.enable = false;
    autostart.enable = false;
  };

  # https://github.com/numtide/srvos/blob/main/nixos/server/default.nix
  systemd = {
    # given that our systems are headless, emergency mode is useless.
    # we prefer the system to attempt to continue booting so
    # that we can hopefully still access it remotely.
    enableEmergencyMode = false;

    # For more detail, see:
    #   https://0pointer.de/blog/projects/watchdog.html
    settings.Manager = {
      # systemd will send a signal to the hardware watchdog at half
      # the interval defined here, so every 10s.
      # If the hardware watchdog does not get a signal for 20s,
      # it will forcefully reboot the system.
      RuntimeWatchdogSec = "20s";
      # Forcefully reboot if the final stage of the reboot
      # hangs without progress for more than 30s.
      # For more info, see:
      #   https://utcc.utoronto.ca/~cks/space/blog/linux/SystemdShutdownWatchdog
      RebootWatchdogSec = "30s";
    };

    sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
    '';
  };

  age = {
    secrets = {
      tailscale = {
        file = "${self}/secrets/tailscale.age";
      };
      kuroneko = {
        file = "${self}/secrets/kuroneko.age";
      };
    };
  };
  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "23.11";
}
