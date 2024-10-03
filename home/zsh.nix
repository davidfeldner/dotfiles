{ ... }:

{
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  shellAliases = {
    ll = "ls -l";
    nxupdate = "sudo nixos-rebuild switch --flake ~/nixos/";
    nxtest = "sudo nixos-rebuild test --flake ~/nixos/";
    icat = "kitten icat";
  };
  sessionVariables = {
    PATH = "$PATH:/home/david/fsharp:/home/david/.dotnet/tools";
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
