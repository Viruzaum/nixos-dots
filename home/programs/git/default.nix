{config, ...}: let
  inherit (config.var.git) username;
  inherit (config.var.git) email;
in {
  programs.git = {
    enable = true;
    userName = username;
    userEmail = email;
    signing = {
      key = "~/.ssh/id_ed25519";
      signByDefault = true;
      format = "ssh";
    };
    extraConfig = {
      core.editor = "helix";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}
