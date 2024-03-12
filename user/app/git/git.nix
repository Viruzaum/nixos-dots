{ pkgs, ... }:

{
  home.packages = [ pkgs.git ];
  programs.git.enable = true;
  programs.git.userName = "Viruzaum";
  programs.git.userEmail = "gustavomelati@gmail.com";
  programs.git.extraConfig = {
    init.defaultBranch = "main";
    safe.directory = "/home/viruz/.dotfiles";
  };

  programs.gh.enable = true;
  programs.gh.gitCredentialHelper.enable = true;
}
