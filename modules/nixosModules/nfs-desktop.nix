{ ... }:
{
  flake.nixosModules.nfs-desktop = {
    fileSystems."/mnt/cache" = {
      device = "192.168.1.211:/cache";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
      ];
    };
    fileSystems."/mnt/media" = {
      device = "192.168.1.211:/media";
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
