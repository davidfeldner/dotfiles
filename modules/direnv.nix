{ ... }:
{
  flake.nixosModules.direnv =
    { ... }:
    {
      programs.direnv = {
        enableFishIntegration = true;
        enable = true;
      };
    };
}
