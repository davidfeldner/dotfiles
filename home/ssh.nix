{ ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "cos" = {
        hostname = "cos.itu.dk";
        user = "dafe";
        identityFile = "/home/david/Nextcloud/School/OSC/OSC.pub";
      };
      "pi" = {
        hostname = "192.168.1.44";
        user = "pi";
      };
    };
  };
}
