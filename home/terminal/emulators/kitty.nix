{...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    themeFile = "GruvboxMaterialDarkHard";
    settings = {
      background_opacity = "0.8";
    };
  };
}
