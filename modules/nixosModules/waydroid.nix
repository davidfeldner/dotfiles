{
  flake.modules.nixos.waydroid =
    { pkgs, ... }:
    {
      virtualisation.waydroid.enable = true;
      virtualisation.waydroid.package = pkgs.waydroid-nftables;
    };
}
