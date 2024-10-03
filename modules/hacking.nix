{ pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    burpsuite
    exiftool
    nmap
    rustscan
    feroxbuster
    ffuf
    openvpn
    sqlmap
    hashcat
    dig
    cewl
    gdb
    gef
    ghidra
    wireshark
    pwntools
    python312Packages.pwntools
  ];

  networking.extraHosts = ''
    10.129.87.171 sightless.htb
  '';
}
