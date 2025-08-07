{lib, ...}: {
  programs.kitty = {
    enable = true;
    themeFile = "GruvboxMaterialDarkHard";
    settings = {
      # background_opacity = lib.mkForce "0.8";
    };
    shellIntegration.enableFishIntegration = true;
  };
}
