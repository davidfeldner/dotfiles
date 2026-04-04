_: {
  flake.modules.homeManager.freetube =
    {
      pkgs,
      lib,
      inputs,
      ...
    }:
    let
      # freetube = pkgs.freetube.overrideAttrs (oldAttrs: rec {
      #   version = "0.24.0";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "FreeTubeApp";
      #     repo = "FreeTube";
      #     tag = "v0.24.0-beta";
      #     hash = "sha256-4XyN7ENsDwLNB/dt7pp8z0sbdmHSNIyVEHlp5GXIues=";
      #   };
      #   yarnHash = "sha256-9rO/XYfOf1TEQOpb5clCfdTiuDeynpnk6L4WpcIIWGk=";
      #   yarnOfflineCache = pkgs.fetchYarnDeps {
      #     yarnLock = "${src}/yarn.lock";
      #     hash = yarnHash;
      #   };
      # });
      inherit (inputs.pin.legacyPackages.${pkgs.stdenv.hostPlatform.system}) freetube;
    in
    {
      home.packages = [ freetube ];
    };
}
