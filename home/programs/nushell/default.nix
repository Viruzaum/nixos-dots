{
  # i can't figure out how to make any of this works i'm going back to fish
  programs = {
    nushell = {
      enable = true;
      configFile.text = ''
        $env.config = {
        show_banner: false,
        edit_mode: "vi",
          completions: {
            algorithm: "fuzzy"
          }
        }
      '';
      envFile.text = ''
      '';
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
        battery.disabled = true;
      };
    };
  };
}
