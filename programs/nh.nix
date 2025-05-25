{ flakePath, ... }: {
  programs.nh.enable = true;

  home.sessionVariables.NH_HOME_FLAKE = flakePath;
}
