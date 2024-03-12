{
  config,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  #boot.extraModulePackages = with config.boot.kernelPackages; [ drivetemp ];
  boot.kernelModules = ["drivetemp"];
}
