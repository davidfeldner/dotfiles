{ ... }:
{
  flake.nixosModules.docker =
    { ... }:
    {
      virtualisation.docker = {
        enable = true;
        logDriver = "json-file";
      };
    };
}
