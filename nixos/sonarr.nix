{
  services.sonarr = {
    enable = true;
    dataDir = "/home/viruz/.config/Sonarr/";
    user = "viruz";
    openFirewall = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];
}
