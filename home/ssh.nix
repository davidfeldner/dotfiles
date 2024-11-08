{ ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "cos" = {
        hostname = "cos.itu.dk";
        user = "dafe";
        identityFile = "/home/david/Nextcloud/School/OSC/OSC";
      };
      "pi" = {
        hostname = "192.168.1.44";
        user = "pi";
      };
      "secJump" = {
        hostname = "130.226.143.130";
        user = "pensim";
      };
      "sec" = {
        hostname = "10.0.1.23";
        user = "student";
        proxyJump = "secJump";
      };
    };
  };
}
