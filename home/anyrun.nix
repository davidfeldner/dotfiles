{ inputs, pkgs, ... }:

{
  imports = [
    inputs.anyrun.homeManagerModules.default

  ];
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        #randr
        rink
        shell
        symbols
        websearch
      ];
      x = {
        fraction = 0.5;
      };
      y = {
        absolute = 15;
      };
      width = {
        fraction = 0.3;
      };
      height = {
        absolute = 0;
      };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = null;
    };
    extraCss = ''
            * {
          all: unset;
          font-size: 1.3rem;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
          background: transparent;
      }

      #match.activatable {
          border-radius: 16px;
          padding: 0.3rem 0.9rem;
          margin-top: 0.01rem;
      }
      #match.activatable:first-child {
          margin-top: 0.7rem;
      }
      #match.activatable:last-child {
          margin-bottom: 0.6rem;
      }

      #plugin:hover #match.activatable {
          border-radius: 10px;
          padding: 0.3rem;
          margin-top: 0.01rem;
          margin-bottom: 0;
      }

      #match:selected,
      #match:hover,
      #plugin:hover {
          background: #2e3131;
      }

      #entry {
          background: #0b0f10;
          border: 1px solid #0b0f10;
          border-radius: 16px;
          margin: 0.5rem;
          padding: 0.3rem 1rem;
      }

      list > #plugin {
          border-radius: 16px;
          margin: 0 0.3rem;
      }
      list > #plugin:first-child {
          margin-top: 0.3rem;
      }
      list > #plugin:last-child {
          margin-bottom: 0.3rem;
      }
      list > #plugin:hover {
          padding: 0.6rem;
      }

      box#main {
          background: #0b0f10;
          box-shadow: inset 0 0 0 1px #0b0f10, 0 0 0 1px #0b0f10;
          border-radius: 24px;
          padding: 0.3rem;
      }

    '';

  };
}