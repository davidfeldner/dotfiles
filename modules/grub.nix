{ ... }:
{
  flake.nixosModules.grub =
    { config, pkgs, ... }:

    let
      sekiroGrubTheme = pkgs.stdenv.mkDerivation {
        pname = "sekiro-grub-theme";
        version = "unstable-2024";

        src = pkgs.fetchFromGitHub {
          owner = "semimqmo";
          repo = "sekiro_grub_theme";
          rev = "1affe05";
          sha256 = "sha256-wTr5S/17uwQXkWwElqBKIV1J3QUP6W2Qx2Nw0SaM7Qk=";
        };

        installPhase = ''
          cp -r Sekiro $out

          # Apply 2560x1440 patch
          sed -i 's/sekiro_1920x1080.png/sekiro_2560x1440.png/' $out/theme.txt
        '';
      };
    in
    {
      boot.loader.grub = {
        enable = true;

        # Point to the copied version in /boot
        theme = sekiroGrubTheme;
      };

    };
}
