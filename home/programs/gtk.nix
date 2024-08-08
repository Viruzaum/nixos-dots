{
  pkgs,
  config,
  ...
}: {
  home.pointerCursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "Inter";
      package = pkgs.google-fonts.override {fonts = ["Inter"];};
      size = 9;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      name = "rose-pine";
      package = pkgs.rose-pine-icon-theme;
    };

    theme = {
      name = "rose-pine-icons";
      package = pkgs.rose-pine-gtk-theme;
    };
  };
}
