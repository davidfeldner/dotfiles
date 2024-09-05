{ ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "osc" = {
        hostname = "cos.itu.dk";
        user = "dafe";
        identityFile = "/home/david/Nextcloud/School/OSC/OSC";
      };
      "pi" = {
        hostname = "192.168.1.44";
        user = "pi";
      };
    };
  };
}
