{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ./variables.nix

    # Programs
    ../../home/programs/helix
    ../../home/programs/shell
    # ../../home/programs/nushell
    ../../home/programs/fastfetch
    ../../home/programs/git
    ../../home/programs/kitty
    # ../../home/programs/mpv
    ../../home/programs/mpd
    ../../home/programs/beets
    ../../home/programs/lazygit
    ../../home/programs/nh
    ../../home/programs/syncthing
    # ../../home/programs/mangohud
    # ../../home/programs/mako
    # ../../home/programs/kdeconnect
    # ../../home/programs/fcitx5
    ../../home/programs/nix-index
    # ../../home/programs/thunderbird
    # ../../home/programs/walker

    # Scripts
    #../../home/scripts # All scripts

    # System (Desktop environment like stuff)
    # ../../home/system/niri
    # ../../home/system/quickshell
    # ../../home/system/hyprland
    # ../../home/system/hypridle
    # ../../home/system/hyprlock
    # ../../home/system/hyprpanel
    # ../../home/system/hyprpaper
    # ../../home/system/gtk
    # ../../home/system/xdg

    inputs.agenix.homeManagerModules.age
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      # (vesktop.override {
      #   withSystemVencord = false;
      # })
      # equibop
      # discord
      bitwarden
      # inputs.zen-browser.packages.${pkgs.system}.default
      # anki-bin
      # inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
      deluge-gtk
      # intel-gpu-tools
      nicotine-plus
      # zapzap
      # syncplay
      # inputs.umu.packages.${pkgs.system}.umu-launcher
      # lutris
      # zed-editor
      # prismlauncher
      statix
      manix
      deadnix
      inputs.agenix.packages.${pkgs.system}.default
      # tealdeer
      zellij
      # nur.repos.ataraxiasjel.waydroid-script
      # cinny-desktop
      # olympus
      # telegram-desktop
      # mission-center
      # modrinth-app
      btop
      # nautilus
    ];

    # Import my profile picture, used by the hyprpanel dashboard
    # file.".profile_picture.png" = {source = ./profile_picture.png;};

    # Don't touch this
    stateVersion = "23.11";
  };

  stylix.targets.helix.enable = false;

  programs.home-manager.enable = true;
}
