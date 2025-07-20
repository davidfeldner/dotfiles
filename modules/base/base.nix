{
  pkgs,
  ...
}:

{
  imports = [
    ./fish.nix
    ./fixes.nix
    ./grub.nix
    ./locale.nix
    ./networking.nix
    ./user.nix
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

}
