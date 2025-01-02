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
    #cewl
    gdb
    gef
    ghidra
    pwntools
    python312Packages.pwntools
  ];
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  programs.proxychains = {
    enable = true;
    package = pkgs.proxychains-ng;
    proxies = {
      myproxy = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 1080;
      };
    };
  };

  networking.extraHosts = ''
    10.129.87.171 sightless.htb
    10.10.11.23   permx.htb lms.permx.htb www.permx.htb
  '';
}
