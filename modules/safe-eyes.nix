{ ... }:
{
  flake.nixosModules.safeeyes =
    { pkgs, lib, ... }:
    let
      inherit (pkgs) alsa-utils wlrctl xorg;
    in
    {
      nixpkgs.overlays = [
        (_final: prev: {
          safeeyes = prev.safeeyes.overrideAttrs (_old: {
            preFixup = ''
              makeWrapperArgs+=(
                "''${gappsWrapperArgs[@]}"
                --prefix PATH : ${
                  lib.makeBinPath [
                    alsa-utils
                    wlrctl
                    xorg.xprop
                  ]
                }
              )
            '';
          });
        })
      ];
      environment.systemPackages = [ pkgs.safeeyes ];
    };
}
