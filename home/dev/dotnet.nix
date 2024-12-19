{ pkgs, ... }:

let
  dotnetPkg = (
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_9_0
    ]
  );
in
{
  home.packages = [ dotnetPkg ];
  home.sessionVariables = {
    DOTNET_ROOT = "${dotnetPkg}";
  };

}
