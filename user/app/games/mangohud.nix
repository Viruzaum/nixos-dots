{ ... }:

{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      fps = true;
      frametime = true;
      ram = true;
      swap = true;
      gpu_stats = false;
      cpu_stats = true;
      cpu_temp = true;
      throttling_status = true;
      toggle_hud = "Shift_R+F12";
      toggle_hud_position = "Shift_R+F11";
      toggle_fps_limit = "Shift_L+F1";
      toggle_logging = "Shift_L+F2";
      reload_cfg = "Shift_L+F4";
      upload_log = "Shift_L+F3";
    };
  };
}
