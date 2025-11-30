{ user, ... }: {
  programs.git = {
    enable = true;
    ignores = [ ".DS_Store" ];
    lfs.enable = true;
    settings = {
      init.defaultBranch = "main";
      protocol.file.allow = true;
      pull.rebase = true;
      user = {
        inherit (user) name email;
      };
      alias = {
        # Undo the last commit (doesn't undo changes)
        shit = "reset --soft HEAD~1";
        # Resets tracked files to the state of the latest commit
        wipe = "reset --hard";
      };
    };
  };
}
