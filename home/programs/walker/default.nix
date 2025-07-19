{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.walker.homeManagerModules.default];

  programs.walker = {
    enable = true;
    package = pkgs.walker;
    runAsService = true;
  };
}
