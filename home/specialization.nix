{...}: {
  config.theme = {
    wallpaper = let
      url = "https://static.zerochan.net/Tendou.Alice.full.3631666.png";
      sha256 = "gTf08qQa7LQYq69xSGkmOR74adW7rZaBuXf4g+Kx2Hc=";
      ext = "png";
    in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };
}
