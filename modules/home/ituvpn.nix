{ ... }:
{
  flake.modules.homeManager.itu-vpn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        openfortivpn
      ];
    };
}
