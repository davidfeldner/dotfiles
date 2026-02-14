{ ... }:
{
  flake.nixosModules.desktop = {

    #boot.kernelPackages = pkgs.linuxPackages_6_6;

    networking.hostName = "desktop";
    boot.loader.grub.useOSProber = false;
    # Manually add entry since osprober finds extra os, and I can't figure out how to add GRUB_OS_PROBER_SKIP_LIST to grub
    boot.loader.grub.extraEntries = ''
      menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-48DB-FCDA' {
              insmod part_gpt
              insmod fat
              search --no-floppy --fs-uuid --set=root 48DB-FCDA
              chainloader /efi/Microsoft/Boot/bootmgfw.efi
      }
    '';
    environment.variables = {
      # MESA_VK_DEVICE_SELECT = "10de:1b80";
      GSK_RENDERER = "ngl";
    };
    vfio.enable = false; # Isolates GPU for VFIO
  };

  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      imports = [
      ];
      hyprland.extraMonitorSettings = [
        "DVI-D-1, 1440x900,      4480x0, 1"
        "DP-2,    2560x1440@144, 1920x0, 1, vrr, 1"
        "DP-3,    2560x1440@144, 1920x0, 1, vrr, 1"
        "DP-4,    2560x1440@144, 1920x0, 1, vrr, 1"
        "HDMI-A-2, disable"
        "HDMI-A-4, disable"
        "HDMI-A-5, disable"
        "HDMI-A-1, disable"
        "Unknown-1, disable"
      ];
      hyprland.extraWorkspaceSettings = [
        "1,monitor:DP-2,default:true"
        "8,monitor:DVI-D-1,default:true"
        "9,monitor:DVI-D-1"
      ];
      home.packages = with pkgs; [
        grub2
      ];
      #zsh.dualboot = true;
      #fish.dualboot = true;
    };
}
