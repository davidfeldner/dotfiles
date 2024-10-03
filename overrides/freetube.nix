{
  pkgs ? (import <nixpkgs> { }).pkgs,
  electron,
  breakpointHook,
  p7zip,
  makeWrapper,
}:
pkgs.mkYarnPackage rec {
  version = "0.1.0";
  pname = "freetube";
  src = pkgs.fetchgit {
    url = "https://github.com/FreeTubeApp/FreeTube.git";
    rev = "fd3018cd4882134ee2e8fcc1600445c5dfa42d7c";
    sha256 = "sha256-4hoyE9UVGCxHepR/WCQFw4Tfa+JrlEzMr6EBo/Nqa0k=";
  };
  packageJSON = "${src}/package.json";
  yarnLock = "${src}/yarn.lock";
  ELECTRON_SKIP_BINARY_DOWNLOAD = "1";

  nativeBuildInputs = [
    makeWrapper
  ];

  configurePhase = ''
    cp -r $node_modules node_modules
    chmod -R +w node_modules
  '';

  buildPhase = ''
    export ELECTRON_BUILDER_CACHE="$(mktemp -d)"
    mkdir -p $ELECTRON_BUILDER_CACHE/appimage
    cp -r ${appimage} $ELECTRON_BUILDER_CACHE/appimage/appimage-${appimage.version}
    chmod -R 777 $ELECTRON_BUILDER_CACHE/


    yarn --offline run patch-shaka 
    yarn --offline run pack
    yarn --offline run electron-builder -c.electronDist=${electron.dist} -c.electronVersion=${electron.version} --dir -c _scripts/ebuilder.config.js
  '';
  installPhase = ''
    mkdir -p "$out/share/lib/freetube"
    cp -r build/*-unpacked/{locales,resources{,.pak}} "$out/share/lib/freetube"
    makeWrapper '${electron}/bin/electron' "$out/bin/${pname}" \
      --add-flags "$out/share/lib/freetube/resources/app.asar" \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}" \
      --inherit-argv0

  '';
  distPhase = "true";
  # appImageVersion = pkgs.stdenv.mkDerivation {
  #   name = "electron-appimage-version";
  #   version = "0.0.0";
  #   dontStrip = true;
  #   dontPatch = true;
  #   dontUnpack = true;
  #   dontInstall = true;
  #   dontConfigure = true;
  #   buildPhase = ''
  #     mkdir -p $out
  #     strings ${node_modules}/node_modules/app-builder-bin/linux/x64/app-builder | ${pcre}/bin/pcregrep -o1 'appimage-([\d\.]+)' | xargs echo -n > $out/version
  #     strings ${node_modules}/node_modules/app-builder-bin/linux/x64/app-builder | ${pcre}/bin/pcregrep -o1 'electron-build-service\)([A-Za-z0-9\/=\+]+?==)' | xargs echo -n > $out/sha512
  #   '';
  # };

  appimage = pkgs.stdenv.mkDerivation rec {
    name = "electron-appimage";
    dontUnpack = true;
    dontInstall = true;
    version = "12.0.1";
    nativeBuildInputs = [ breakpointHook ];
    archive = pkgs.fetchurl {
      url = "https://github.com/electron-userland/electron-builder-binaries/releases/download/appimage-${version}/appimage-${version}.7z";
      sha256 = "sha256-0S/3648dHsRlLKUjen+9yjOswMdYBFY2/spi3G7LjsQ=";
    };
    buildPhase = ''
      mkdir -p $out
      ${p7zip}/bin/7z x -o$out ${archive} 
    '';
  };

}
