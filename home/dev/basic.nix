{ pkgs, ... }:
{
  home.packages = with pkgs; [

    gnumake
    cargo
    rustc
    rustfmt
    nodejs
    nixfmt-rfc-style
    poetry
    # jetbrains.rider
    go
    gcc
    jdk
    (pkgs.callPackage ../../overrides/fslexyacc.nix { })
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    # userSettings = {
    #   "dotnetAcquisitionExtension.allowInvalidPaths" = true;
    #   "dotnetAcquisitionExtension.sharedExistingDotnetPath" = "/etc/profiles/per-user/david/bin/dotnet";
    # };
    extensions = with pkgs.vscode-extensions; [
      yzhang.markdown-all-in-one
      ms-dotnettools.csharp
      ms-dotnettools.csdevkit
      ms-dotnettools.vscode-dotnet-runtime
      ionide.ionide-fsharp
    ];
  };
}
