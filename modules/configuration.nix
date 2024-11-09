{ lib, pkgs, ... }:

{
  imports = [ ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";

  boot.loader.grub.configurationLimit = 20;

  networking.networkmanager.enable = true;

  # Dont error waiting for NetworkManager online 
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  services.tailscale.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.defaultUserShell = pkgs.zsh;

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
    ];
    #packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    firefox
    neofetch
    killall
    htop
    tmux

    python3
  ];

  programs.adb.enable = true;

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };

  # networking.networkmanager.wifi.scanRandMacAddress = false;
  # networking.networkmanager.wifi.backend = "iwd";
  #networking.wireless.iwd.enable = true;

  stylix.enable = lib.mkDefault false;
  stylix.image = lib.mkDefault ../home/wall.jpg;
  stylix.polarity = "dark";

  services.upower.enable = true; # for end 4 ags bar

  programs.kdeconnect.enable = true;

  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
  # nixpkgs.config.packageOverrides = {
  #   freetube = pkgs.callPackage ../overrides/freetube.nix { };
  # };

  # Mounts /bin with binaries if calling process has it in $PATH, to fx shell scripts work
  services.envfs.enable = true;

  virtualisation.docker.enable = true;

  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
  };

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [ glibc ];

  services.hypridle.enable = true;

  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "DroidSansMono" ]; })
  ];

  system.stateVersion = "24.05";

}
