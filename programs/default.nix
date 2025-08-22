{ pkgs, scripts, ... }: {
  imports = [
    ./git.nix
    ./kitty.nix
    ./mpv.nix
    ./neovim.nix
    ./nh.nix
    ./ssh.nix
    ./wireproxy.nix
  ];

  programs = {
    btop.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fastfetch.enable = true;

    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };

    htop.enable = true;

    ripgrep.enable = true;

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };
  
    yt-dlp = {
      enable = true;
      settings.concurrent-fragments = 8;
    };
  };

  home.packages = with pkgs; [
    coreutils
    curl
    ffmpeg
    killall
    rar
    sshfs
    static-web-server
    tree
    unzip
    wget
    zip
  ] ++ [ scripts.default ];
}
