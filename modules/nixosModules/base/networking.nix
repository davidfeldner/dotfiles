{
  flake.modules.nixos.base-networking = {
    networking.networkmanager.enable = true;

    # services.resolved = {
    #   enable = true;
    # };
    #
  };
}
