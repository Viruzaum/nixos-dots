{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    specialArgs = {inherit inputs self;};
  in {
    mimi = nixosSystem {
      inherit specialArgs;
      modules = [
        ./laptop
        "${self}/pkgs"

        {
          home-manager = {
            extraSpecialArgs = specialArgs;
            backupFileExtension = ".hm-backup";
          };
        }
      ];
    };
  };
}
