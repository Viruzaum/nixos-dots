{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.walker.homeManagerModules.default];

  programs.walker = {
    enable = true;
    # package = pkgs.walker;
    runAsService = true;
    config = {
      terminal = "kitty";
      builtins = {
        applications = {};
        bookmarks = {
          entries = [
            {
              label = "Walker";
              url = "https://github.com/abenz1267/walker";
              keywords = ["walker"];
            }
          ];
        };
        calc = {
          min_chars = 3;
        };
        clipboard = {};
        windows = {};
      };
    };
  };
}
