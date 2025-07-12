{ ... }:
{
  programs.zellij = {
    enable = true;
    exitShellOnExit = true;
    attachExistingSession = true;
    settings = {
      show_startup_tips = false;
      cleanup = true;
    };
  };
}
