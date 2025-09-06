{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [inputs.niri.overlays.niri];
  imports = [inputs.niri.nixosModules.niri];

  programs.niri = {
    enable = true;
    package = pkgs.niri.overrideAttrs (o: {
      patches =
        (o.patches or [])
        ++ [
          (pkgs.fetchpatch {
            url = "https://patch-diff.githubusercontent.com/raw/YaLTeR/niri/pull/2333.diff";
            hash = "sha256-MN3/GyuTKEj7GIZEN/woFzY3xD/tSSeddvvKpAt6czc=";
            name = "fullscreen-refactor";
          })
        ];
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
