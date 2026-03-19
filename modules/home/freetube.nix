{ ... }:
{
  flake.modules.homeManager.freetube =
    {
      pkgs,
      lib,
      ...
    }:
    let
      freetube = pkgs.freetube.overrideAttrs (oldAttrs: rec {
        version = "0.23.15";
        src = pkgs.fetchFromGitHub {
          owner = "FreeTubeApp";
          repo = "FreeTube";
          tag = "v0.23.15-beta";
          hash = "sha256-tYRvR75qbJwt6U4KzT9jrJjO5UznpoALqhUTDkeUlzI=";
        };
        yarnHash = "sha256-sxDlPB3CWbFAm3WZ6AlwuVu/4UFR9Stl3q0wpkUXPPU=";
        yarnOfflineCache = pkgs.fetchYarnDeps {
          yarnLock = "${src}/yarn.lock";
          hash = yarnHash;
        };
      });
    in
    {
      home.packages = [ freetube ];
    };
}
