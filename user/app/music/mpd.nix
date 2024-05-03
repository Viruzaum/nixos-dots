{...}: {
  services.mpd = {
    enable = true;
    musicDirectory = "/home/viruz/a/@home/viruz/music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };

  # services.mpd-discord-rpc.enable = true;

  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "/home/viruz/a/@home/viruz/music";
  };
}
