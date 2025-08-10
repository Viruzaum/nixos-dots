{
  self,
  inputs,
  withSystem,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    specialArgs = {inherit inputs self;};
  in {
    yun = withSystem "x86_64-linux" ({
      pkgs,
      system,
      ...
    }:
      nixosSystem {
        inherit specialArgs;
        modules = [
          ./yun
          "${self}/pkgs"

          inputs.nur.modules.nixos.default

          {
            home-manager = {
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }
        ];
      });
    mimi = withSystem "x86_64-linux" ({
      pkgs,
      system,
      ...
    }:
      nixosSystem {
        inherit specialArgs;
        modules = [
          ./mimi
          "${self}/pkgs"

          inputs.nur.modules.nixos.default

          {
            home-manager = {
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }
        ];
      });
  };
}
