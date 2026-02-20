{ self, ... }:
{

  perSystem =
    {
      lib,
      pkgs,
      ...
    }:
    {

      packages.nordzy-cursors = pkgs.stdenvNoCC.mkDerivation {
        pname = "nordzy-cursors";
        version = "2.4.0";

        src = pkgs.fetchFromGitHub {
          owner = "guillaumeboehm";
          repo = "Nordzy-cursors";
          rev = "v2.4.0";
          hash = "sha256-pPcdlMa3H5RtbqIxvgxDkP4tw76H2UQujXbrINc3MxE=";
        };
        nativeBuildInputs = [
          pkgs.hyprcursor
        ];

        dontDropIconThemeCache = true;

        installPhase = ''
          runHook preInstall
          mkdir -p $out/share/icons/Nordzy-hyprcursors
          cp -a hyprcursors/themes/Nordzy-hyprcursors/. $out/share/icons/Nordzy-hyprcursors/
          runHook postInstall
        '';
        meta = {
          homepage = "https://github.com/guillaumeboehm/Nordzy-cursors";
          description = "Cursor theme using the Nord color palette and based on Vimix and cz-Viator.";
          platforms = lib.platforms.all;
          license = lib.licenses.gpl3;
          maintainers = [ ];
        };
      };

    };
  flake.modules.homeManager.hyprcursor =
    { pkgs, ... }:
    {
      home.pointerCursor = {
        name = "Nordzy-hyprcursors"; # must match the directory name in $out/share/icons/
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.nordzy-cursors;
        hyprcursor.enable = true;
        hyprcursor.size = 32;
      };
    };
}
