{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "viruz";
        email = "gustavomelati@hotmail.com";
      };
      ui = {
        color = "auto";
        default-command = "log";
        paginate = "never";
      };
      signing = {
        behavior = "keep";
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };
      git = {
        sign-on-push = true;
        colocate = true;
      };
      template-aliases = {
        "format_short_signature(signature)" = "signature.name()";
      };
    };
  };
}
