{ ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "under" = {
        hostname = "109.106.244.203";
        user = "itunderground";
      };
      "sim" = {
        hostname = "206.81.20.113";
        user = "root";
        identityFile = "/home/david/6sem/devops/devops";
      };
      "pi" = {
        hostname = "192.168.1.44";
        user = "pi";
      };
    };
  };
}
