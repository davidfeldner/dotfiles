{ self, ... }:
{
  flake.modules.nixos.base =
    {
      pkgs,
      ...
    }:
    {
      imports = with self.modules.nixos; [
        base-fixes
        base-fish
        base-grub
        base-locale
        base-networking
        base-user
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
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
