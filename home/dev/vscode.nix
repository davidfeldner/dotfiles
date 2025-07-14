{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = {
      "[csharp]" = {
        "editor.defaultFormatter" = "csharpier.csharpier-vscode";
      };
      "[xml]" = {
        "editor.defaultFormatter" = "csharpier.csharpier-vscode";
      };
    };
    profiles.default = {
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
        ]);
    };
  };
}
