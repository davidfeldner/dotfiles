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
    jetbrains.rider
    go
    gcc
    vscode-fhs
    (pkgs.callPackage ../../overrides/fslexyacc.nix { })
  ];
}
