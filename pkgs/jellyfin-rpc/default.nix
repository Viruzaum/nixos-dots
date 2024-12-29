{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "jellyfin-rpc";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "Radiicall";
    repo = pname;
    rev = version;
    hash = "sha256-sr82lTOr6RUvYD0CVZMyyRAFjai1oLnRWIszuu7/jE0=";
  };

  cargoHash = "sha256-KHbYM7aWgch+DWF46DpFCCt7JoKR0sasuFO3xPOytWA=";

  meta = {
    description = "Displays the content you're currently watching in jellyfin on Discord!";
    mainProgram = "jellyfin-rpc";
    homepage = "https://github.com/Radiicall/jellyfin-rpc";
    license = lib.licenses.gpl3;
    maintainers = [];
  };
}
