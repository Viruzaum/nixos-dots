{
  pkgs,
  lib,
  ...
}: {
  qt = {
    enable = true;
    platformTheme.name = "gtk2";
    style.name = "gtk2";
    # platformTheme.name = "qtct";
    # style.name = "kvantum";
  };

  gtk = {
    enable = true;

    #font = lib.mkForce {
    #  name = "Inter";
    #  package = pkgs.google-fonts.override {fonts = ["Inter"];};
    #  size = 9;
    #};

    iconTheme = {
      name = "gruvbox-dark-icons";
      package = pkgs.gruvbox-dark-icons-gtk;
    };

    theme = lib.mkForce {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };

    gtk3.extraConfig = {gtk-application-prefer-dark-theme = 1;};

    gtk4.extraConfig = {gtk-application-prefer-dark-theme = 1;};
  };
}
