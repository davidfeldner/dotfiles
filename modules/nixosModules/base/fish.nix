{ ... }:
{
  flake.nixosModules.base-fish =
    { pkgs, ... }:
    {
      users.defaultUserShell = pkgs.fish;
      programs.fish.enable = true;
    };
}
