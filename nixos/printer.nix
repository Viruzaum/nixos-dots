{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.hplip];
  };

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [pkgs.hplipWithPlugin];
}
