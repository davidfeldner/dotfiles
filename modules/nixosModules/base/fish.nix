{
  flake.modules.nixos.base-fish =
    { pkgs, ... }:
    {
      users.defaultUserShell = pkgs.fish;
      programs.fish.enable = true;
    };
}
