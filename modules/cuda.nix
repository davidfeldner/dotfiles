{ ... }:
{
  flake.nixosModules.cuda =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.cudatoolkit ];
      hardware.nvidia-container-toolkit.enable = true;
      virtualisation.docker.daemon.settings.features.cdi = true;

    };
}
