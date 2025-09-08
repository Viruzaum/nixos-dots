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
              url = "https://patch-diff.githubusercontent.com/raw/YaLTeR/niri/pull/2333.diff";
              hash = "sha256-s+DzYSezzP9CABBOEmPnW/dd9DhamMAiOr3mmrXiz/Q=";
              name = "fullscreen-refactor";
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
