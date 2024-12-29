_: {
  programs.beets = {
    enable = true;
    settings = {
      directory = "/home/viruz/a/@home/viruz/music/";
      library = "/home/viruz/a/@home/viruz/data/musiclibrary.db";
      import = {
        move = "yes";
      };
    };
  };
}
