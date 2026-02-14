{ ... }:
{
  flake.nixosModules.wifi =
    { pkgs, config, ... }:
    {
      virtualisation.virtualbox.host.enable = true;
      users.extraGroups.vboxusers.members = [ config.user.defaultUser ];
      environment.systemPackages = with pkgs; [
        vagrant
      ];

    };
}
