{ ... }:
{
  flake.nixosModules.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        nerd-fonts.droid-sans-mono
      ];

    };
}
