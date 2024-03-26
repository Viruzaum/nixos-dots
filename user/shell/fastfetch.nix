{pkgs, ...}: {
  home.packages = with pkgs; [fastfetch];

  home.file.".config/fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "modules": [
        "title",
        "separator",
        "os",
        "kernel",
        "uptime",
        "packages",
        "shell",
        "display",
        "de",
        "wm",
        "theme",
        "font",
        "terminal",
        "cpu",
        "gpu",
        "memory",
        "swap",
        "break",
        "colors"
      ]
    }
  '';
}
