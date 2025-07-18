{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = ../../../hosts/mimi/profile_picture.png;
        height = 9;
      };
      display = {
        constants = ["██ "];
      };
      modules = [
        {
          key = "{$1}Distro";
          keyColor = "38;5;210";
          type = "os";
        }
        {
          key = "{$1}Kernel";
          keyColor = "38;5;84";
          type = "kernel";
        }
        {
          key = "{$1}Shell";
          keyColor = "38;5;147";
          type = "shell";
        }
        {
          key = "{$1}WM";
          keyColor = "38;5;44";
          type = "wm";
        }
        {
          key = "{$1}CPU";
          keyColor = "38;5;75";
          type = "cpu";
        }
        {
          key = "{$1}GPU";
          keyColor = "38;5;100";
          type = "gpu";
        }
        {
          key = "{$1}Memory";
          keyColor = "38;5;123";
          type = "memory";
        }
        {
          type = "command";
          key = "{$1}OSage";
          keyColor = "33";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
      ];
    };
  };
}
