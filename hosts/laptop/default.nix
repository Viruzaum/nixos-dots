{
  inputs,
  config,
  self,
  ...
}: {
  imports = [
    ../../nixos/audio.nix
    ../../nixos/auto-upgrade.nix
    ../../nixos/bluetooth.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/intel.nix
    ../../nixos/network-manager.nix
    ../../nixos/jellyfin.nix
    ../../nixos/nix.nix
    ../../nixos/power.nix
    ../../nixos/sonarr.nix
    ../../nixos/steam.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/timezone.nix
    ../../nixos/tuigreet.nix
    ../../nixos/tailscale.nix
    ../../nixos/users.nix
    ../../nixos/nix-ld.nix
    ../../nixos/utils.nix
    ../../nixos/xdg-portal.nix
    ../../nixos/otd.nix
    ../../nixos/variables-config.nix
    ../../nixos/zram.nix

    ../../themes/stylix/stylix.nix

    ./hardware-configuration.nix
    ./variables.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    inputs.chaotic.nixosModules.default
  ];

  age = {
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "${config.home-manager.users.viruz.home.homeDirectory}/.ssh/id_ed25519"
    ];
    secrets.tailscale = {
      file = "${self}/secrets/tailscale.age";
    };
  };
  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "23.11";
}
