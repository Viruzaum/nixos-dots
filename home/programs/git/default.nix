{config, ...}: let
  inherit (config.var.git) username;
  inherit (config.var.git) email;
in {
  programs.git = {
    enable = true;
    userName = username;
    userEmail = email;
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}
