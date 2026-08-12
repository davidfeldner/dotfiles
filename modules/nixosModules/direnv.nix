{
  flake.modules.nixos.direnv = {
    programs.direnv = {
      enableFishIntegration = true;
      enable = true;
    };
  };
}
