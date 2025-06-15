{
  config,
  pkgs,
  ...
}: let
  inherit (config.var) username;
in {
  programs.fish.enable = true;
  users = {
    defaultUserShell = pkgs.fish;
    users.${username} = {
      isNormalUser = true;
      description = "${username} account";
      extraGroups = ["networkmanager" "wheel" "scanner" "lp" "vboxusers"];
    };
  };
}
