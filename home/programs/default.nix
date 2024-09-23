{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # ./browsers/firefox.nix
    ./media
    ./games/mangohud.nix
    ./gtk.nix
    ./qt.nix
  ];

  home.packages = with pkgs; [
    mission-center
    jetbrains.idea-community
    libreoffice
    modrinth-app
    inputs.zen-browser.packages."${pkgs.system}".generic
    thunderbird
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/json" = "zen.desktop";
      "application/pdf" = "zen.desktop";
      "application/x-xpinstall" = "zen.desktop";
      "application/xhtml+xml" = "zen.desktop";
      "text/html" = "zen.desktop";
      "text/xml" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
    };
  };
}
