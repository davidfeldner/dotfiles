{
  flake.modules.homeManager.dotnet =
    { pkgs, ... }:

    let
      dotnetPkg =
        with pkgs.dotnetCorePackages;
        combinePackages [
          sdk_9_0
          sdk_10_0
          sdk_11_0
        ];
    in
    {
      home.packages = [ dotnetPkg ];
      home.sessionVariables = {
        DOTNET_ROOT = "${dotnetPkg}";
        DOTNET_CLI_TELEMETRY_OPTOUT = "1";
      };

    };
}
