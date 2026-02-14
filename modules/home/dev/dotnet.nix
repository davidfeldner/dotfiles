{ ... }:
{
  flake.modules.homeManager.dotnet =
    { pkgs, ... }:

    let
      dotnetPkg = (
        with pkgs.dotnetCorePackages;
        combinePackages [
          sdk_6_0
          sdk_8_0
          sdk_9_0
        ]
      );
    in
    {
      home.packages = [ dotnetPkg ];
      home.sessionVariables = {
        DOTNET_ROOT = "${dotnetPkg}";
        DOTNET_CLI_TELEMETRY_OPTOUT = "1";
      };

    };
}
