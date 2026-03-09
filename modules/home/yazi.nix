_: {
  flake.modules.homeManager.yazi = {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      shellWrapperName = "y";
    };
  };
}
