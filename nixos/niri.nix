{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [inputs.niri.overlays.niri];
  imports = [inputs.niri.nixosModules.niri];

  programs.niri = {
    enable = true;
    package = pkgs.niri.overrideAttrs (o: rec {
      src = pkgs.applyPatches {
        inherit (o) src;
        patches =
          (o.patches or [])
          ++ [
            (pkgs.fetchpatch {
              url = "https://patch-diff.githubusercontent.com/raw/YaLTeR/niri/pull/2376.diff";
              hash = "sha256-NkzP3LBhz/S2B1N16yD1MWySj/AJeI2Vy4zTdbAmiXM=";
              name = "true-maximize";
            })
          ];
      };

      cargoDeps = pkgs.rustPlatform.importCargoLock {
        lockFile = "${src}/Cargo.lock"; # use the lockfile after patches
        allowBuiltinFetchGit = true;
      };
    });
  };

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1";
  };
  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    libsecret
    xwayland-satellite-stable
  ];
}
