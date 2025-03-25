{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    # userSettings = {
    #   "dotnetAcquisitionExtension.allowInvalidPaths" = true;
    #   "dotnetAcquisitionExtension.sharedExistingDotnetPath" = "/etc/profiles/per-user/david/bin/dotnet";
    # };
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
          svelte.svelte-vscode
        ])
        ++ (with pkgs.open-vsx; [
          llvm-vs-code-extensions.vscode-clangd
          rust-lang.rust-analyzer
          octref.vetur
          golang.go
          editorconfig.editorconfig
          dbaeumer.vscode-eslint
          yoavbls.pretty-ts-errors
          redhat.java
          ms-azuretools.vscode-docker
          jnoortheen.nix-ide
        ]);
    };
  };
}

