{ ... }:
{
  # systemd.network.enable = true;
  # systemd.network.wait-online.enable = false;

  #systemd.network = {
  #  netdevs."10-microvm".netdevConfig = {
  #    Kind = "bridge";
  #    Name = "microvm";
  #  };
  #  networks."10-microvm" = {
  #    matchConfig.Name = "microvm";
  #    networkConfig = {
  #      DHCPServer = true;
  #      IPv6SendRA = true;
  #    };
  #    addresses = [ {
  #      Address = "10.0.0.1/24";
  #    } {
  #      Address = "fd12:3456:789a::1/64";
  #    } ];
  #    ipv6Prefixes = [ {
  #      Prefix = "fd12:3456:789a::/64";
  #    } ];
  #  };
  #  networks.microvm-eth0 = {
  #    matchConfig.Name = "vm-*";
  #    networkConfig.Bridge = "microvm";
  #  };
  #}; 
  #networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  # networking.networkmanager.insertNameservers = [ "1.1.1.1" "8.8.8.8"];
  # services.resolved.enable = true;

  # networking.firewall.enable = false;
  #networking.firewall.allowedUDPPorts = [ 67 ];

  #hardware.bluetooth.enable = true;
  #hardware.bluetooth.powerOnBoot = true;

  # networking.nat = {
  #   enable = true;
  #   enableIPv6 = true;
  #   # Change this to the interface with upstream Internet access
  #   externalInterface = "wlp2s0";
  #   internalInterfaces = [ "microvm" ];
  # };
}
