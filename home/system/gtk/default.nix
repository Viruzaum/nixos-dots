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
      name = "rose-pine-icons";
      package = pkgs.rose-pine-icon-theme;
    };

    theme = lib.mkForce {
      name = "rose-pine-gtk";
      package = pkgs.rose-pine-gtk-theme;
    };

    gtk3.extraConfig = {gtk-application-prefer-dark-theme = 1;};

    gtk4.extraConfig = {gtk-application-prefer-dark-theme = 1;};
  };
}
