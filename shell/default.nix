{ pkgs, lib, ... }: {
  imports = [
    ./zsh
  ];

  home = {
    shell.enableShellIntegration = true;

    shellAliases = {
      flake = "nix flake";
      ls = "ls --color=auto";
      l = "ls";
      ll = "ls -lh";
      la = "ls -A";
      lla = "ll -A";
      kssh = "kitten ssh";
      static-web-server = "caffeinate -s static-web-server";
    };
  };
}
