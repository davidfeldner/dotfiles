{
  flake.modules.nixos.base-locale = {
    time.timeZone = "Europe/Copenhagen";

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
