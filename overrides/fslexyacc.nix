{
  lib,
  pkgs,
  breakpointHook,
  ...
}:

pkgs.stdenv.mkDerivation {
  pname = "FsLexYacc";
  version = "11.3.0";

  src = pkgs.fetchurl {
    url = "https://www.nuget.org/api/v2/package/FsLexYacc/11.3.0";
    hash = "sha256-qPNKpZcfp9Mo0fDBdlZgkyCF6NLFqw+SCRYsaFcenk8=";

  };
  # postUnpack = ''
  #   chmod -R +r .
  # '';
  # src = fetchNuGet {
  #   pname = "FsLexYacc";
  #   baseName = "FsLexYacc";
  #   version = "11.3.0";
  #   sha256 = "sha256-qPNKpZcfp9Mo0fDBdlZgkyCF6NLFqw+SCRYsaFcenk8=";
  #   outputFiles = [ "*" ];
  # };

  # postFetch = ''
  #   cp $out src.zip
  #   ${pkgs.zip}/bin/unzip src.zip
  # '';

  dontUnpack = true;

  nativeBuildInputs = [
    breakpointHook
    pkgs.unzip
  ];
  buildInputs = [

  ];

  installPhase = ''
    fslib="$out/share/lib"
    mkdir -p "$fslib"
    unzip $src -d "$fslib"
    mkdir "$out/bin"
    ln -s "$fslib/build/fslex/net6.0/fslex"  $out/bin/
    ln -s "$fslib/build/fsyacc/net6.0/fsyacc"  $out/bin/
  '';

  meta = {
    description = "";
    homepage = "";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ ];
  };
}
