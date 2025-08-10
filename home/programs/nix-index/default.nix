{inputs, ...}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];
  programs = {
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    nix-index-database = {
      comma.enable = true;
    };
  };
}
