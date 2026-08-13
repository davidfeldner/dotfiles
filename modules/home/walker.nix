{
  flake.modules.homeManager.walker =
    {
      inputs,
      pkgs,
      osConfig,
      ...
    }:
    {
      imports = [ inputs.walker.homeManagerModules.default ];

      config = {
        home.packages = with pkgs; [
          sqlite
          fd
          libqalculate
          imagemagick
        ];
        programs.elephant = {
          provider = {
            files.settings = {
              search_dirs = [
                "/home/${osConfig.my.user}/Downloads"
              ];
            };
            clipboard.settings = {
              text_editor_cmd = "kitty -- vim %FILE%";
            };
            websearch.settings = {
              entries = [
                {
                  name = "My NixOS";
                  prefix = "nx";
                  url = "https://mynixos.com/search?q=%TERM%";
                  default = false;
                }
                {
                  name = "Duckduckgo";
                  default = true;
                  url = "https://www.duckduckgo.com/search?q=%TERM%";
                }
                {
                  name = "Chat GPT";
                  default = false;
                  prefix = "gpt";
                  url = "https://chatgpt.com/?prompt=%TERM%";
                }
              ];
            };

          };
        };

        programs.walker = {
          enable = true;
          runAsService = true;
          config = {
            providers.prefixes = [
              {
                prefix = "+";
                provider = "bluetooth";
              }
            ];

          };
        };

      };
    };
}
