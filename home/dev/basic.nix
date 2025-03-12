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
    clang-tools
    jdk
    (pkgs.callPackage ../../overrides/fslexyacc.nix { })
  ];
}
