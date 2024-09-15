{...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    theme = "Gruvbox Dark Hard";
    settings = {
      background_opacity = "0.8";
    };
  };
}
