_: {
  services.mpd = {
    enable = true;
    musicDirectory = "/home/viruz/music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };

  # services.mpd-discord-rpc.enable = true;
  services.mpd-mpris.enable = true;

  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "/home/viruz/music";
  };
}
