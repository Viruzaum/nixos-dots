{
  inputs,
  config,
  self,
  pkgs,
  ...
}: {
  imports = [
    ../../nixos/amd.nix
    ../../nixos/audio.nix
    # ../../nixos/bluetooth.nix
    # ../../nixos/cosmic.nix
    # ../../nixos/deluge.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    # ../../nixos/intel.nix
    ../../nixos/network-manager.nix
    # ../../nixos/jellyfin.nix
    ../../nixos/niri.nix
    ../../nixos/nix.nix
    ../../nixos/printer.nix
    ../../nixos/power.nix
    ../../nixos/openssh.nix
    ../../nixos/ratbag.nix
    # ../../nixos/sonarr.nix
    ../../nixos/steam.nix
    # ../../nixos/sunshine.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/timezone.nix
    ../../nixos/tailscale.nix
    ../../nixos/users.nix
    ../../nixos/nix-ld.nix
    ../../nixos/utils.nix
    ../../nixos/xdg-portal.nix
    ../../nixos/otd.nix
    ../../nixos/variables-config.nix
    ../../nixos/waydroid.nix
    # ../../nixos/zram.nix

    ../../themes/stylix/stylix.nix

    ./hardware-configuration.nix
    ./variables.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    inputs.chaotic.nixosModules.default
  ];

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb.overrideAttrs (prev: {
      name = "openrgb-git";
      src = pkgs.fetchFromGitLab {
        owner = "CalcProgrammer1";
        repo = "OpenRGB";
        rev = "1836b5e4175bd8b7ff15e3c49bcdc6d2e60232d5";
        hash = "sha256-hu1mHEIFlulBhBJYcE7BDkM+H23qF8Gc/8gbnHViytk=";
      };
      postPatch = ''
        patchShebangs scripts/build-udev-rules.sh
        substituteInPlace scripts/build-udev-rules.sh \
        --replace-fail "/usr/bin/env chmod" "${pkgs.coreutils}/bin/chmod"
        substituteInPlace OpenRGB.pro \
        --replace-fail "udev_rules systemd_service" "udev_rules"
      '';
    });
  };

  age = {
    # identityPaths = [
    #   "/etc/ssh/ssh_host_ed25519_key"
    #   "${config.home-manager.users.viruz.home.homeDirectory}/.ssh/id_ed25519"
    # ];
    secrets = {
      tailscale = {
        file = "${self}/secrets/tailscale.age";
      };
      #kuroneko = {
      #  file = "${self}/secrets/kuroneko.age";
      #};
    };
  };
  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "25.05";
}
