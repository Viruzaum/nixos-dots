{...}: {
  imports = [
    ./programs
    # ./shell/starship.nix
    ./emulators/kitty.nix
    ./shell/fish.nix
    ./shell/zoxide.nix
  ];

  # add environment variables
  home.sessionVariables = {
    # clean up ~
    # LESSHISTFILE = "${cache}/less/history";
    # LESSKEY = "${conf}/less/lesskey";

    # WINEPREFIX = "${data}/wine";
    # XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

    EDITOR = "hx";
    # DIRENV_LOG_FORMAT = "";

    # auto-run programs using nix-index-database
    # NIX_AUTO_RUN = "1";
  };
}
