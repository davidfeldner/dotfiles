{
  flake.modules.homeManager.mangohud = {

    programs.mangohud = {
      enable = true;
      settings = {
        output_folder = "~/mangohud/";
        full = true;
      };
    };
  };
}
