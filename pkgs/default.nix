{pkgs, ...}: {
  nixpkgs.config.packageOverrides = {
    jellyfin-rpc = pkgs.callPackage ./jellyfin-rpc {};
  };
}
