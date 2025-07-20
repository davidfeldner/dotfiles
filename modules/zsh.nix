{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.zsh;
  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
}
