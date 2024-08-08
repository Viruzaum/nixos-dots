{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.viruz = {
      settings = {
        "browser.tabs.closeWindowWithLastTab" = false;
        "accessibility.force_disabled" = 1;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
        sponsorblock
        dearrow
        youtube-shorts-block
        enhanced-h264ify
        tridactyl
        (pkgs.nur.repos.rycee.firefox-addons."7tv")
        augmented-steam
        buster-captcha-solver
        copy-link-text
        image-search-options
        i-dont-care-about-cookies
        libredirect
        modrinthify
        stylus
        tampermonkey
      ];
    };
  };
}
