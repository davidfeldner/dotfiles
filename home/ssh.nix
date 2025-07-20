{ ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "under" = {
        hostname = "109.106.244.203";
        user = "itunderground";
      };
      "pi" = {
        hostname = "192.168.1.44";
        user = "pi";
      };
    };
  };
}
