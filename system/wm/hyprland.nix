{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.nixosModules.default

    ./wayland.nix
    ./pipewire.nix
  ];

  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland.override {
    #   legacyRenderer = true;
    # };
  };

  xdg.portal = {
    enable = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland" "gtk"];
    };
  };
}
