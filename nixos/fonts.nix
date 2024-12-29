{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      roboto
      inter
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg
      openmoji-color
      twemoji-color-font
    ];

    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        monospace = ["FiraCode Nerd Font Mono" "Noto Color Emoji"];
        sansSerif = ["SFProDisplay Nerd Font" "Noto Color Emoji"];
        serif = ["SFProDisplay Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
