{ config, pkgs, ... }:

{

	programs.firefox = import ./home/firefox.nix { inherit pkgs; };

  home.file."/home/alice/proton.key" = {
    enable = true;
    text = builtins.readFile ./proton.key;
  };

  home.stateVersion = "24.05";
}
