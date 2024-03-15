{
  config,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelModules = ["drivetemp"];
}
