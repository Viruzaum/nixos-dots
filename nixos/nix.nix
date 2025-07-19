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
      ];
      trusted-public-keys = [
      ];
    };
  };
}
