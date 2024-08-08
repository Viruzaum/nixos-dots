{
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = ["drivetemp"];
}
