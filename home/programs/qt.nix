{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme = "kde";
    style.name = "breeze";
  };

  # home.packages = with pkgs; [
  # kdePackages.breeze
  # ];
}
