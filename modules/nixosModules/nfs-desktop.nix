{ ... }:
{
  flake.nixosModules.nfs-desktop = {
    fileSystems."/mnt/storage" = {
      device = "192.168.1.211:/storage";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
      ];
    };
    # optional, but ensures rpc-statsd is running for on demand mounting
    boot.supportedFilesystems = [ "nfs" ];
  };
}
