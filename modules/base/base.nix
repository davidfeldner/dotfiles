{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./greetd.nix
    ./printing.nix
    ./audio.nix
    ./fish.nix
  ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";

  boot.loader.grub.configurationLimit = 20;

  networking.networkmanager.enable = true;

  networking.firewall.enable = false;

  # Dont error waiting for NetworkManager online
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  boot.initrd.systemd.network.wait-online.enable = false;

  services.tailscale.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs;
    nur.flake = inputs.nur;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.david = {
    isNormalUser = true;
    description = "david";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "KVM"
      "docker"
      "input"
      "wireshark"
      "usbusers"
      "uinput"
    ];
    #packages = with pkgs; [];
  };

  # Define a custom udev rule
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="0660", GROUP="usbusers"
  '';

  nix.settings.trusted-users = [
    "root"
    "david"
  ];

  # services.resolved = {
  #   enable = true;
  # };
  #
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    firefox
    killall
    htop
    tmux
    python3
  ];

  stylix.enable = lib.mkDefault false;
  stylix.image = lib.mkDefault ../home/wall.jpg;
  stylix.polarity = "dark";

  programs.kdeconnect.enable = true;

  # Mounts /bin with binaries if calling process has it in $PATH, to fx shell scripts work
  services.envfs.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.logDriver = "json-file";

  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
  };

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [ glibc ];

  services.hypridle.enable = true;

  services.gnome.gnome-keyring.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.droid-sans-mono
  ];

  system.stateVersion = "24.05";

}
