{ pkgs, ... }:
{
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "david" ];
  environment.systemPackages = with pkgs; [
    vagrant
  ];

}
