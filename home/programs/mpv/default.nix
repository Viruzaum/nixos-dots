{
  pkgs,
  self,
  ...
}: {
  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto-safe";
      vo = "gpu";
      profile = "gpu-hq";
      gpu-context = "wayland";
      geometry = "100%:100%";
      ytdl-raw-options = "force-ipv4=,format=bestvideo[height<=1080]+bestaudio/best[height<=1080]";
      volume = 100;
      no-osc = "";
      keepaspect = "yes";
      keepaspect-window = "yes";
    };
    scripts = [
      pkgs.mpvScripts.mpvacious
      pkgs.mpvScripts.mpris
    ];
  };
  # services.jellyfin-mpv-shim = {
  #   enable = true;
  #   mpvConfig = self.nixosConfigurations.yun.config.home-manager.users.viruz.programs.mpv.config;
  # };
}
