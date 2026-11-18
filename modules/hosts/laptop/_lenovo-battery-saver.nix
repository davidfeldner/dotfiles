{ pkgs, ... }: {
  systemd.services.lenovo-battery-saver = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    description = "Set lenovo battery saver on login";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'";
    };
  };
}
