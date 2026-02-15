{ ... }:
{
  flake.nixosModules.wifi =
    { inputs, ... }:
    {
      # Enable networking
      networking.networkmanager = {
        enable = true;
        wifi.powersave = false;
      };

      # https://kisonecat.com/blog/eduroam-openssl-wpa-supplicant/
      nixpkgs.config.packageOverrides = pkgs: {
        wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (attrs: {
          patches = attrs.patches ++ [ (inputs.self + "/assets/eduroam.patch") ];
        });
      };
    };
}
