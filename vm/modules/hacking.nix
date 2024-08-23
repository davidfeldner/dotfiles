{ config, pkgs, lib, ... }:

{

 nixpkgs.config.allowUnfree = true;

 environment.systemPackages = with pkgs; [
    burpsuite
    exiftool
    nmap
    rustscan
    feroxbuster
    ffuf
  ];
}