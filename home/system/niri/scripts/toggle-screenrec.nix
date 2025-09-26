{
  pkgs,
  lib,
  ...
}:
pkgs.writeScriptBin "toggle-screenrec.fish" ''
  #!/usr/bin/env fish

  function screenrec
    set audio_device (${lib.getExe' pkgs.pulseaudio "pactl"} list short sources | string match --regex 'alsa_output\..+\.monitor')

    if test -z "$audio_device"
        echo "Error: Could not find an audio device." >&2
        echo "Make sure you have a monitor source available in 'pactl list short sources'." >&2
        exit 1
    end

    set filename (date +'%F-%H-%M-%S')

    echo "Found audio device: $audio_device"
    echo "Starting screen recording... (Press Ctrl+C to stop)"
    touch /tmp/recordilock
    ${lib.getExe pkgs.wl-screenrec} --audio --audio-device=$audio_device -f ~/videos/tmp.mp4 --low-power=off

    ${lib.getExe pkgs.ffmpeg} -y -i ~/videos/tmp.mp4 \
        -c:a copy \
        -c:v libx264 -preset medium -crf 21 \
        -movflags +faststart \
        -b:v 3M -maxrate 4.5M -bufsize 6M \
        ~/videos/$filename.mp4

    rm -f /tmp/recordilock

    echo file:///home/viruz/videos/$filename.mp4 | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} -t text/uri-list
    ${lib.getExe pkgs.libnotify} "recording finished and copied :3"
  end

  if test -f /tmp/recordilock
      kill -s INT wl-screenrec
  else
    screenrec
  end
''
