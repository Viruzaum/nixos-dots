{pkgs, ...}: {
  environment.systemPackages = with pkgs; [blueman];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.firmware = [pkgs.broadcom-bt-firmware];

  services.blueman.enable = true;
}
