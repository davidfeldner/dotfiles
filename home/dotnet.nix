{ pkgs, ... }:

let
  dotnetPkg = (
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_7_0
      sdk_8_0
    ]
  );
in
{
  home.packages = [ dotnetPkg ];
  home.sessionVariables = {
    DOTNET_ROOT = "${dotnetPkg}";
  };

}
