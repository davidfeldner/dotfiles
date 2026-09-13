{
  flake.modules.nixos.sops = { config, pkgs, ... }: {
    environment.systemPackages = [ pkgs.sops ];
    sops = {
      defaultSopsFile = ../../secrets/shared.yaml;

      age.sshKeyPaths = [
        "/home/${config.my.user}/.ssh/id_ed25519"
      ];

      secrets.my-secret = { };
    };
  };

}
