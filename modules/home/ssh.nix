_: {
  flake.modules.homeManager.ssh =
    _:

    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = {
          "*" = {
            forwardAgent = false;
            serverAliveInterval = 0;
            serverAliveCountMax = 3;
            compression = false;
            addKeysToAgent = "false";

            controlMaster = "auto";
            controlPath = "~/.ssh/master-%r@%n:%p";
            controlPersist = "10m";

            hashKnownHosts = false;
            userKnownHostsFile = "~/.ssh/known_hosts";
          };
          "under" = {
            hostname = "109.106.244.203";
            user = "itunderground";
          };
          "pi" = {
            hostname = "192.168.1.44";
            user = "pi";
          };
          "server" = {
            hostname = "192.168.1.211";
            user = "david";
            port = 5522;
          };
          "iot" = {
            hostname = "100.78.83.123";
            user = "pi";
          };
        };
      };
    };
}
