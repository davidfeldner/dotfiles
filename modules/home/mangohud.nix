_: {
  flake.modules.homeManager.mangohud = _: {

    programs.mangohud = {
      enable = true;
      settings = {
        output_folder = "~/mangohud/";
        full = true;
      };
    };
  };
}
