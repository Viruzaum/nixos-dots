{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
  };
  nix = {
    package = pkgs.lix;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    channel.enable = false;
    extraOptions = ''
      warn-dirty = false
    '';
    settings = {
      auto-optimise-store = false;
      experimental-features = ["nix-command" "flakes"];

      trusted-users = ["root" "@wheel"];

      substituters = [
        # "https://hyprland.cachix.org"
        "https://jovian-nixos.cachix.org"
        # "https://anyrun.cachix.org"
        # "https://helix.cachix.org"
        "https://cosmic.cachix.org"
      ];
      trusted-public-keys = [
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "jovian-nixos.cachix.org-1:mAWLjAxLNlfxAnozUjOqGj4AxQwC17MXwOfu7msVlAo="
        # "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        # "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
    };
  };
}
