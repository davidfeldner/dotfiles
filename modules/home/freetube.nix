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
        version = "0.23.12";
        src = pkgs.fetchFromGitHub {
          owner = "FreeTubeApp";
          repo = "FreeTube";
          tag = "v0.23.12-beta";
          hash = "sha256-DH5uT3dPDFZnFYoiMjxpNouNDRbWDctVqvDwHpUlnkY=";
        };
        yarnHash = "sha256-sM9CkDnATSEUf/uuUyT4JuRmjzwa1WzIyNYEw69MPtU=";
        yarnOfflineCache = pkgs.fetchYarnDeps {
          yarnLock = "${src}/yarn.lock";
          hash = yarnHash;
        };
      });
    in
    {
      home.packages = [ pkgs.freetube ];
    };
}
