{ ... }:

{
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  shellAliases = {
    ll = "ls -l";
    nxupdate = "sudo nixos-rebuild switch";
    nxconfig = "sudo vim /etc/nixos/configuration.nix";
    nxtest = "sudo nixos-rebuild test";
  };
  #history = {
  #  size = 10000;
  #  path = "${config.xdg.dataHome}/zsh/history";
  #};
  oh-my-zsh = {
    enable = true;
    plugins = [ ];
  };
}
