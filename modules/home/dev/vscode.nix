_: {
  flake.modules.homeManager.vscode =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      myJupyter = pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "jupyter";
        publisher = "ms-toolsai";
        version = "2025.7.0"; # choose the version you need
        sha256 = "sha256-wedMPo+mL3yvb9WqJComlyZWvSSaJXv/4LWcl0wwqdQ="; # from nix-prefetch-url
      };

      settingsPaths = [
        "${config.home.homeDirectory}/.config/VSCodium/User/settings.json"
        "${config.home.homeDirectory}/.config/Code/User/settings.json"
      ];

      codeSettings = {
        enable = true;
        profiles.default = {
          userSettings = {
            "[csharp]" = {
              "editor.defaultFormatter" = "csharpier.csharpier-vscode";
            };
            "[xml]" = {
              "editor.defaultFormatter" = "csharpier.csharpier-vscode";
            };
            "workbench.colorCustomizations" = {
              "selection.background" = "#${config.lib.stylix.colors.base0B}";
            };
          };
          extensions =
            (with pkgs.vscode-marketplace; [
              yzhang.markdown-all-in-one
              # ms-dotnettools.csharp
              # ms-dotnettools.csdevkit
              # ms-dotnettools.vscode-dotnet-runtime
              ionide.ionide-fsharp
              ms-python.python
              ms-python.debugpy
              ms-python.vscode-pylance
              # ms-python.pylint
              svelte.svelte-vscode
              esbenp.prettier-vscode
              erlang-language-platform.erlang-language-platform
              platformio.platformio-ide
              ms-vscode.cpptools
            ])
            ++ (with pkgs.vscode-marketplace; [
              llvm-vs-code-extensions.vscode-clangd
              rust-lang.rust-analyzer
              vue.volar
              golang.go
              editorconfig.editorconfig
              dbaeumer.vscode-eslint
              yoavbls.pretty-ts-errors
              redhat.java
              redhat.vscode-xml
              csharpier.csharpier-vscode
              ms-azuretools.vscode-docker
              jnoortheen.nix-ide
              streetsidesoftware.code-spell-checker
              jnoortheen.nix-ide
              tomoki1207.pdf
              scala-lang.scala
              scalameta.metals
              sleistner.vscode-fileutils
              lintangwisesa.arduino
              langium.langium-vscode
              vitest.explorer
            ])
            ++ [ myJupyter ];
        };
      };

      # phase1 moves the previous settings file,
      # phase2 then combines previous and nix generated to a new file
      phase1 =
        settingsPath:
        lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
          settings_file="${settingsPath}"
          if [ -f "$settings_file" ]; then
            echo "Moving vscode settings file: $settings_file"
            mv $settings_file "$settings_file.tmp"
          fi
        '';
      phase2 =
        settingsPath:
        lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          settings_file="${settingsPath}"
          generated_symlink="$settings_file"
          prev_settings_file="$settings_file.tmp"

          echo "Checking settings file: $settings_file"

          # Initialize with empty JSON objects
          generated_content='{}'
          prev_content='{}'

          # Check and read generated symlink
          if [ -L "$generated_symlink" ]; then
            echo "Found generated_symlink"
            generated_content=$(cat "$generated_symlink" 2>/dev/null || echo '{}')
            echo "generated content: $generated_content"
            $DRY_RUN_CMD rm "$generated_symlink"
          fi

          # Check and read previous settings file
          if [ -s "$prev_settings_file" ]; then
            echo "Found previous content"
            prev_content=$(cat "$prev_settings_file" 2>/dev/null || echo '{}')
            echo "previous content: $prev_content"
            $DRY_RUN_CMD rm "$prev_settings_file"
          fi

          # Merge and create new settings file
          $DRY_RUN_CMD ${pkgs.jq}/bin/jq -n \
            --argjson a "$generated_content" \
            --argjson b "$prev_content" \
            '$a + $b' > "$settings_file"

          echo "Settings.json for vscode file created"
        '';
    in
    {
      programs.vscodium = codeSettings;
      programs.vscode = codeSettings // {
        profiles.default.extensions = codeSettings.profiles.default.extensions ++ [
          pkgs.vscode-marketplace.ms-vsliveshare.vsliveshare
        ];
        package = lib.lowPrio pkgs.vscode;
      };

      home.activation =
        settingsPaths
        |> lib.imap0 (
          index: settingsPath: {
            "fix-vscode-settings_phase1_${toString index}" = phase1 settingsPath;
            "fix-vscode-settings_phase2_${toString index}" = phase2 settingsPath;
          }
        )
        |> lib.mergeAttrsList;
    };
}
