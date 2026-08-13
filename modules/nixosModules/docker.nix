{
  flake.modules.nixos.docker = { config, ... }: {
    users.users.${config.user.defaultUser}.extraGroups = [ "docker" ];
    virtualisation.docker = {
      enable = true;
      logDriver = "json-file";
    };
  };
}
