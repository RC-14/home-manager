{ user, ... }: {
  programs.git = {
    enable = true;
    userName = user.name;
    userEmail = user.email;
    ignores = [ ".DS_Store" ];
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      protocol.file.allow = true;
      pull.rebase = true;
    };
    aliases = {
      # Undo the last commit (doesn't undo changes)
      shit = "reset --soft HEAD~1";
      # Resets tracked files to the state of the latest commit
      wipe = "reset --hard";
    };
  };
}
