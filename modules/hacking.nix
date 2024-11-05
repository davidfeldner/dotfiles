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
    pwntools
    python312Packages.pwntools
  ];
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;

  networking.extraHosts = ''
    10.129.87.171 sightless.htb
    10.10.11.23   permx.htb lms.permx.htb www.permx.htb
  '';
}
