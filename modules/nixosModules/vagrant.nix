{
  flake.modules.nixos.vagrant =
    { pkgs, config, ... }:
    {
      virtualisation.virtualbox.host.enable = true;
      users.extraGroups.vboxusers.members = [ config.user.defaultUser ];
      environment.systemPackages = with pkgs; [
        vagrant
      ];

    };
}
