{ pkgs, ... }:

{
  imports = [ ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  #systemd.network.enable = true;
  #systemd.network.wait-online.enable = false;
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
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  networking.firewall.enable = false;
  #networking.firewall.allowedUDPPorts = [ 67 ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # networking.nat = {
  #   enable = true;
  #   enableIPv6 = true;
  #   # Change this to the interface with upstream Internet access
  #   externalInterface = "wlp2s0";
  #   internalInterfaces = [ "microvm" ];
  # };

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
    kitty
    neofetch
    freetube
    nextcloud-client
    vesktop
    swayosd
    bat
    brightnessctl
    wl-clipboard-rs
    killall
    htop
    vscode-fhs
    grimblast
    nixpkgs-fmt
    waypipe
    nixos-generators
    tmux
    obsidian
    python3
    poetry
    unzip
    zip
    file
    pavucontrol
    p7zip
    xdg-utils
    sway-audio-idle-inhibit
    protonvpn-gui
    gcc
    nextcloud-client
    nodejs
    cargo
    rustc
    nixfmt-rfc-style
  ];
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
  nixpkgs.config.packageOverrides = {
    freetube = pkgs.callPackage ./overrides/freetube.nix { };
  };

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
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "DroidSansMono" ]; })
  ];

  system.stateVersion = "24.05";

}
