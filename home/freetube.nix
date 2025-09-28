{
  pkgs,
  lib,
  ...
}:
let
  freetube = pkgs.freetube.overrideAttrs (oldAttrs: rec {
    version = "0.23.8";
    src = pkgs.fetchFromGitHub {
      owner = "FreeTubeApp";
      repo = "FreeTube";
      tag = "v0.23.8-beta";
      hash = "sha256-CHp/6/E/v6UdSe3xoB66Ot24WuZDPdmNyUG1w2w3bX0=";
    };
    yarnHash = "sha256-ia5wLRt3Hmo4/dsB1/rhGWGJ7LMnVR9ju9lSlQZDTTg=";
    yarnOfflineCache = pkgs.fetchYarnDeps {
      yarnLock = "${src}/yarn.lock";
      hash = yarnHash;
    };
  });
in
{
  home.packages = [ pkgs.freetube ];
}
