{
  pkgs,
  ...
}:
let
  freetube = pkgs.freetube.overrideAttrs (oldAttrs: rec {
    version = "0.23.7";
    src = pkgs.fetchFromGitHub {
      owner = "FreeTubeApp";
      repo = "FreeTube";
      tag = "v0.23.7-beta";
      hash = "sha256-252d80xCWBZnPHnRESxRqYzT40Gu/LLBbzXr2nIJW/I=";
    };
    yarnHash = "sha256-ia5wLRt3Hmo4/dsB1/rhGWGJ7LMnVR9ju9lSlQZDTTg=";
    yarnOfflineCache = pkgs.fetchYarnDeps {
      yarnLock = "${src}/yarn.lock";
      hash = yarnHash;
    };
  });
in
{
  home.packages = [ freetube ];
}
