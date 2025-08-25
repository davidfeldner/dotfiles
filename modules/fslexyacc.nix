{
  lib,
  pkgs,
  ...
}:

let
  fslexyacc = pkgs.stdenv.mkDerivation {
    pname = "FsLexYacc";
    version = "11.3.0";
    src = pkgs.fetchurl {
      url = "https://www.nuget.org/api/v2/package/FsLexYacc/11.3.0";
      hash = "sha256-qPNKpZcfp9Mo0fDBdlZgkyCF6NLFqw+SCRYsaFcenk8=";
    };
    dontUnpack = true;
    nativeBuildInputs = [
      pkgs.unzip
      pkgs.makeWrapper
    ];
    propagatedBuildInputs = [ pkgs.dotnet-runtime_6 ];
    installPhase = ''
      fslib="$out/share/lib"
      mkdir -p "$fslib"
      unzip $src -d "$fslib"
      mkdir "$out/bin"

      # Create wrapper scripts that use the specific .NET runtime
      makeWrapper "${pkgs.dotnet-runtime_6}/bin/dotnet" "$out/bin/fslex" \
        --add-flags "$fslib/build/fslex/net6.0/fslex.dll"

      makeWrapper "${pkgs.dotnet-runtime_6}/bin/dotnet" "$out/bin/fsyacc" \
        --add-flags "$fslib/build/fsyacc/net6.0/fsyacc.dll"
    '';
    meta = {
      description = "FslexYacc package providing fslex and fsyacc cli";
      homepage = "https://github.com/fsprojects/FsLexYacc/";
      license = lib.licenses.unfree;
      maintainers = with lib.maintainers; [ ];
    };
  };
in
{
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-6.0.36"
  ];
  environment.systemPackages = [ fslexyacc ];
}
