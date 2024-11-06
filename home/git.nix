{ ... }:
{
  programs.git = {
    enable = true;
    aliases = {
      bigblame = "blame -w -C -C -C";
      staash = "stash --all";
      undo = "reset --soft HEAD~1";
      amend = "commit --amend";
      safeForce = "push --force-with-lease";
      graph = "log --all --decorate --oneline --graph";
      st = "status";
      aa = "!git add -A && git status";
      cm = "commit -m";
    };
    extraConfig = {
      pull = {
        rebase = true;
      };
      commit.gpgsign = true;
      rerere.enabled = true;
      branch.sort = "-comitterdate";
      column.ui = "auto";
      gpg = {
        sign = true;
        format = "ssh";
      };
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };
}
