{ ... }:
{
  flake.nixosModules.safeeyes =
    { pkgs, lib, ... }:
    let
      inherit (pkgs) alsa-utils wlrctl xprop;
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
                    xprop
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
