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
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
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
          # ms-vsliveshare.vsliveshare
        ])
        ++ (with pkgs.open-vsx; [
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
        ])
        ++ [ myJupyter ];
    };
  };

  # p1 moves the previous settings file, p2 then combines previous and nix generated to a new file
  home.activation.fix-vscode-settings_p1 = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    settings_file="$HOME/.config/VSCodium/User/settings.json"
    if [ -f "$settings_file" ]; then
      echo "Moving vscode settings file: $settings_file"
      mv $settings_file "$settings_file.tmp"
    fi

  '';

  home.activation.fix-vscode-settings_p2 = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    settings_file="$HOME/.config/VSCodium/User/settings.json"
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
}
