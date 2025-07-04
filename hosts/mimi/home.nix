{
  pkgs,
  config,
  inputs,
  self,
  ...
}: {
  imports = [
    ./variables.nix

    # Programs
    ../../home/programs/helix
    ../../home/programs/shell
    ../../home/programs/nushell
    ../../home/programs/fastfetch
    ../../home/programs/git
    ../../home/programs/kitty
    ../../home/programs/mpv
    ../../home/programs/mpd
    ../../home/programs/beets
    ../../home/programs/lazygit
    ../../home/programs/nh
    ../../home/programs/syncthing
    ../../home/programs/mangohud
    ../../home/programs/mako
    ../../home/programs/kdeconnect
    ../../home/programs/fcitx5
    ../../home/programs/nix-index
    ../../home/programs/thunderbird

    # Scripts
    #../../home/scripts # All scripts

    # System (Desktop environment like stuff)
    ../../home/system/niri
    # ../../home/system/quickshell
    # ../../home/system/hyprland
    # ../../home/system/hypridle
    # ../../home/system/hyprlock
    # ../../home/system/hyprpanel
    # ../../home/system/hyprpaper
    # ../../home/system/gtk
    ../../home/system/xdg

    inputs.agenix.homeManagerModules.age
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      (vesktop.override {
        withSystemVencord = false;
        # electron = pkgs.electron_33;
      }) # Chat
      (inputs.nekocord.lib.patch pkgs {
        install.openasar = true;
        version = {
          branch = "dev";
          buildId = 398;
          hash = "sha256-MBuZmpcLlWMEJ3e6IWFTRDSTp3L+FctnO3EFz2CvwIg=";
        };
      })
      .build
      .nekocord
      bitwarden # Password manager
      inputs.zen-browser.packages.${pkgs.system}.default
      anki-bin
      inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
      deluge-gtk
      intel-gpu-tools
      nicotine-plus
      zapzap
      gimp
      syncplay
      # inputs.umu.packages.${pkgs.system}.umu-launcher
      lutris
      zed-editor
      nixd
      libreoffice
      # libreoffice
      prismlauncher
      rustup
      nil
      alejandra
      statix
      manix
      deadnix
      inputs.agenix.packages.${pkgs.system}.default
      tealdeer
      zellij
      nur.repos.ataraxiasjel.waydroid-script
      cinny-desktop
      olympus
      telegram-desktop
      mission-center

      # Utils
      zip
      unzip
      optipng
      pfetch
      pandoc
      btop

      # Just cool
      peaclock
      cbonsai
      pipes
      cmatrix
    ];

    # Import my profile picture, used by the hyprpanel dashboard
    file.".profile_picture.png" = {source = ./profile_picture.png;};

    # Don't touch this
    stateVersion = "23.11";
  };

  stylix.targets.helix.enable = false;

  programs.home-manager.enable = true;
}
