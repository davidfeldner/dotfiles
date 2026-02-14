{ ... }:
{
  flake.nixosModules.base-locale =
    { ... }:
    {
      time.timeZone = "Europe/Copenhagen";

      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };
    };
}
