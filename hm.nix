{
  inputs,
  config,
  systemName,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.user.defaultUser} = import ./hosts/${systemName}/home.nix;
  };
}
