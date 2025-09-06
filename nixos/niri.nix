{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [inputs.niri.overlays.niri];
  imports = [inputs.niri.nixosModules.niri];

  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
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
