{
  ...
}: {
  imports = [
    ./wayland.nix
    ./pipewire.nix
  ];

  programs.hyprland = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland" "gtk"];
    };
  };

}
