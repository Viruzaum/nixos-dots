{pkgs, ...}: {
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
    };
    # scripts = [
    # (pkgs.callPackage ./../../../pkgs/mpv-progressbar {})
    # ];
  };
}
