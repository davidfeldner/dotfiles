{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    cargo
    rustc
    rustfmt
    nodejs
    nixfmt
    # jetbrains.rider
    go
    gcc
    clang-tools
    jdk
    pnpm
    fzf
    python3
    erlang
    beam28Packages.rebar3
    arduino-ide
  ];
}
