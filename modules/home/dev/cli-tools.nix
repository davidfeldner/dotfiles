{ ... }:
{
  flake.modules.homeManager.dev-cli =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bat
        unzip
        zip
        file
        p7zip
        ripgrep
        nixos-generators
      ];
    };
}
