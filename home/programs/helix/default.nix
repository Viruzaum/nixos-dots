{
  pkgs,
  lib,
  ...
}: let
  zellij = lib.getExe pkgs.zellij;
in {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor.line-number = "relative";
      keys.normal = {
        backspace.b = ":sh ${zellij} run -f -- cargo build";
        backspace.r = ":sh ${zellij} run -f -- cargo run";
        backspace.t = ":sh ${zellij} run -f -- cargo test";
      };
    };
    languages = {
      language-server = {
        nil.command = "${pkgs.nil}/bin/nil";
        rust-analyzer.config = {
          check.command = "clippy";
        };
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
