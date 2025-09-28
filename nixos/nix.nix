{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
  };
  nix = {
    package = pkgs.lixPackageSets.stable.lix;
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

  nixpkgs.overlays = [
    (final: prev: {
      inherit
        (prev.lixPackageSets.stable)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];
}
