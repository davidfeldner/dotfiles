{
  flake.modules.nixos.openssh = { sops, ... }: {
    services.openssh = {
      enable = true;
      ports = [ 5522 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "david" ];
      };
    };
    users.users."david".openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0Uj+xKvHfMrsnjczZ1qmeqQyAIwJYNcix1h5R7V4E5 david@laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILokHPjNhZDPCbL8bFfk062eUlj6pQZpBmNL7aZhV1oF u0_a234@localhost"
    ];
  };
}
