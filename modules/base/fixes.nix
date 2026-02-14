{ ... }:
{
  flake.nixosModules.base-fixes =
    # General nice to have nix options/fixes for stuff
    {
      pkgs,
      inputs,
      lib,
      ...
    }:
    {

      nix.settings = {
        substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };

      networking.firewall.enable = false;

      # Dont error waiting for NetworkManager online
      systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
      boot.initrd.systemd.network.wait-online.enable = false;

      nix.registry = {
        nixpkgs.flake = inputs.nixpkgs;
        nur.flake = inputs.nur;
      };

      # Allow non root access to usb device
      services.udev.extraRules = ''
        SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="0660", GROUP="usbusers"
      '';

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # Mounts /bin with binaries if calling process has it in $PATH, to fx shell scripts work
      services.envfs.enable = true;

      programs.nix-ld.enable = true;

      programs.nix-ld.libraries = with pkgs; [ glibc ];

      nixpkgs.config.permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "dotnet-runtime-6.0.36"
      ];

      environment.systemPackages = [
        pkgs.android-tools
      ];
    };
}
