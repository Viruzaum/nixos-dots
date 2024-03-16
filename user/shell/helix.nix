{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language-server = {
        nil.command = "${pkgs.nil}/bin/nil";
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = [{name = "nil";}];
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
        }
        {
          name = "fish";
          auto-format = true;
        }
      ];
    };
  };
}
