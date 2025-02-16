{pkgs, ...}: {
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.systemPackages = with pkgs; [
    chronos
    cosmic-reader
    examine
    observatory
    cosmic-ext-calculator
    cosmic-ext-applet-clipboard-manager
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    COSMIC_DATA_CONTROL_ENABLED = "1";
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
  };
}
