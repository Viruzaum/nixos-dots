{
  pkgs,
  lib,
  # inputs,
  ...
}: let
  zellij = lib.getExe pkgs.zellij;
in {
  programs.helix = {
    enable = true;
    # package = inputs.helix.packages.${pkgs.system}.default;
    defaultEditor = true;
    settings = {
      theme = "grv";
      editor = {
        end-of-line-diagnostics = "hint";
      };

      editor.line-number = "relative";
      editor.inline-diagnostics = {
        cursor-line = "warning";
      };
      keys.normal = {
        backspace.b = ":sh ${zellij} run -f -- cargo build";
        backspace.r = ":sh ${zellij} run -f -- cargo run";
        backspace.t = ":sh ${zellij} run -f -- cargo test";
      };
    };
    languages = {
      language-server = {
        nil.command = "${pkgs.nil}/bin/nil";
        nixd.command = "${pkgs.nixd}/bin/nixd";
        rust-analyzer.config = {
          check.command = "clippy";
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = [{name = "nixd";} {name = "nil";}];
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
        }
        {
          name = "fish";
          auto-format = true;
        }
      ];
    };
    themes = {
      grv = let
        bg0 = "#282828"; # main background
        "bg0_5" = "#303030"; # ever so slightly lighter than the main background
        bg1 = "#3c3836";
        bg2 = "#504945";
        bg3 = "#665c54";
        bg4 = "#7c6f64";

        fg0 = "#fbf1c7";
        fg1 = "#ebdbb2"; # main foreground
        fg2 = "#d5c4a1";
        fg3 = "#bdae93";
        fg4 = "#a89984"; # gray0

        # gray0 = "#a89984";
        gray1 = "#928374";

        red0 = "#cc241d"; # neutral
        red1 = "#fb4934"; # bright
        red2 = "#fc6b59"; # brighter
        green0 = "#98971a";
        green1 = "#b8bb26";
        yellow0 = "#d79921";
        yellow1 = "#fabd2f";
        lua-blue = "#000080";
        blue0 = "#458588";
        blue1 = "#83a598";
        purple0 = "#b16286";
        purple1 = "#d3869b";
        aqua0 = "#689d6a";
        aqua1 = "#8ec07c";
        orange0 = "#d65d0e";
        orange1 = "#fe8019";
      in {
        "attribute" = purple1;
        "comment" = {
          fg = gray1;
          modifiers = ["italic"];
        };
        "constant.builtin" = {
          fg = purple1;
          modifiers = ["bold"];
        };
        "constant" = purple1;
        "constructor" = {
          fg = aqua1;
          modifiers = ["bold"];
        };
        "escape" = {
          fg = fg2;
          modifiers = ["bold"];
        };
        "function.builtin" = {
          fg = fg1;
          modifiers = ["bold"];
        };
        "function" = fg1;
        "function.macro" = red0;
        "function.special" = purple1;
        "keyword.operator" = red2;
        "keyword.directive" = red0;
        "keyword.storage" = red2;
        "keyword.function" = red2;
        "keyword" = red1;
        "label" = purple1;
        "namespace" = green1;
        "operator" = blue1;
        "punctuation.delimiter" = fg3;
        "punctuation.special" = purple0;
        "punctuation" = fg3;
        "string" = green1;
        "string.special.symbol" = yellow1;
        "string.special.path" = purple0;
        "tag" = fg3;
        "text" = fg2;
        "text.literal" = fg4;
        "text.title" = {
          fg = blue0;
          modifiers = ["bold"];
        };
        "text.strong" = {
          fg = fg2;
          modifiers = ["bold"];
        };
        "text.emphasis" = {
          fg = fg2;
          modifiers = ["italic"];
        };
        "text.uri" = {
          fg = blue1;
          underline = {color = blue1;};
        };
        "text.reference" = purple1;
        "type" = aqua1;
        "type.builtin" = {
          fg = aqua1;
          modifiers = ["bold"];
        };
        "variable.builtin" = orange1;
        "variable" = {
          fg = fg0;
          modifiers = ["italic"];
        };
        "variable.parameter" = {
          fg = fg0;
          modifiers = ["underlined"];
        };
        "variable.other.member" = blue1;
        # matched text in the picker/menus
        "special" = {
          fg = red1;
          modifiers = ["bold"];
        };
        "tabstop" = {
          bg = bg2;
          modifiers = ["bold"];
        };

        "markup.heading" = blue0;
        "markup.heading.1" = {
          fg = red0;
          modifiers = ["bold"];
        };
        "markup.heading.2" = {
          fg = orange0;
          modifiers = ["bold"];
        };
        "markup.heading.3" = {
          fg = yellow0;
          modifiers = ["bold"];
        };
        "markup.heading.4" = {
          fg = green0;
          modifiers = ["bold"];
        };
        "markup.heading.5" = {
          fg = blue0;
          modifiers = ["bold"];
        };
        "markup.heading.6" = {
          fg = fg0;
          modifiers = ["bold"];
        };
        "markup.bold" = {modifiers = ["bold"];};
        "markup.italic" = {modifiers = ["italic"];};
        "markup.link.label" = {
          fg = blue1;
          modifiers = "[underlined]";
        };
        "markup.link.url" = {
          fg = blue1;
          modifiers = ["underlined"];
        };
        "markup.link.text" = purple1;
        "markup.list.numbered" = aqua0;
        "markup.list.unnumbered" = aqua1;
        "markup.list.checked" = aqua1;
        "markup.list.unchecked" = fg4;
        "markup.raw" = fg4;
        "markup.quote" = {
          fg = fg2;
          modifiers = ["italic"];
        };
        "markup.strikethrough" = {modifiers = ["crossed_out"];};

        # vcs (git) things
        "diff.plus" = {fg = green1;};
        "diff.minus" = {fg = red1;};
        "diff.delta" = {fg = orange1;};
        "diff.delta.moved" = {fg = aqua1;};

        "ui.background" = {
          #bg = bg0;
        };
        "ui.linenr" = bg4;
        "ui.linenr.selected" = yellow1;
        "ui.statusline" = {
          fg = fg1;
          bg = bg2;
        };
        "ui.statusline.inactive" = {
          fg = fg4;
          bg = bg1;
        };
        "ui.statusline.select" = {bg = lua-blue;};
        "ui.popup" = {bg = bg1;};
        "ui.popup.info" = {bg = bg1;};
        "ui.picker.header.column" = {underline.style = "line";};
        "ui.picker.header.column.active" = {
          fg = fg0;
          modifiers = ["bold"];
          underline.style = "line";
        };
        "ui.window" = {bg = bg1;};
        "ui.help" = {
          bg = bg1;
          fg = fg1;
        };
        "ui.text" = fg1;
        "ui.text.inactive" = gray1;
        "ui.text.info" = fg1;
        "ui.text.focus" = {
          fg = fg1;
          modifiers = ["bold"];
        };
        "ui.text.directory" = blue1;
        "ui.selection.primary" = {modifiers = ["reversed"];};
        "ui.selection" = {bg = bg3;};
        "ui.cursorline.primary" = {bg = bg1;};
        "ui.cursor.primary" = {
          bg = bg3;
          modifiers = ["underlined"];
        };
        "ui.cursor.match" = {modifiers = ["underlined"];};
        "ui.menu" = {
          fg = fg1;
          bg = bg2;
        };
        "ui.menu.selected" = {
          bg = bg3;
          modifiers = ["bold"];
        };
        "ui.virtual.whitespace" = bg2;
        "ui.virtual.ruler" = {bg = bg0_5;};
        "ui.virtual.indent-guide" = bg0_5;
        "ui.virtual.wrap" = bg3;
        "ui.virtual.inlay-hint" = {
          fg = bg3;
          modifiers = ["italic"];
        };
        "ui.virtual.jump-label" = yellow1;

        "warning" = orange1;
        "error" = red1;
        "info" = fg2;
        "hint" = blue1;

        "diagnostic.error.underline" = {
          color = red1;
          style = "curl";
        };
        "diagnostic.warning.underline" = {
          color = orange1;
          style = "curl";
        };
        "diagnostic.info.underline" = {
          color = fg2;
          style = "curl";
        };
        "diagnostic.hint.underline" = {
          color = blue1;
          style = "curl";
        };
        "diagnostic.underline" = {
          color = blue1;
          style = "line";
        };
        "diagnostic.unnecessary" = {modifiers = ["dim"];};
        "diagnostic.deprecated" = {modifiers = ["crossed_out"];};

        # rainbow = ["red1", "orange1", "yellow1", "green1", "blue1", "purple1"]
      };
    };
  };
}
