_: {
  flake.nixosModules.waydroid =
    { pkgs, ... }:
    {
      virtualisation.waydroid.enable = true;
      virtualisation.waydroid.package = pkgs.waydroid-nftables;
    };
}
