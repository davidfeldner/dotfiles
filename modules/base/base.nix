{ self, ... }:
{
  flake.nixosModules.base =
    {
      pkgs,
      ...
    }:
    {
      imports = with self.nixosModules; [
        base-fish
        base-grub
        base-locale
        base-networking
        base-user
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      environment.systemPackages = with pkgs; [
        neovim
        wget
        git
        killall
        htop
      ];

      system.stateVersion = "24.05";

    };
}
