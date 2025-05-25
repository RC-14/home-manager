{ pkgs, lib, ... }: { programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  history = rec {
    append = true;
    expireDuplicatesFirst = true;
    saveNoDups = true;
    share = false;

    save = 10000000;
    size = save;
  };
  syntaxHighlighting = {
    enable = true;
    highlighters = [
      "main"
      "brackets"
    ];
  };

  completionInit = "autoload -U compinit && compinit";
  profileExtra = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
  initContent = ''
    mcd() {
      if [[ $# -ne 1 ]]; then
        echo "Usage: mcd <directory>"
        return 1
      fi
      mkdir -p "$1" && cd "$1"
    }
  '';

  plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    {
      name = "powerlevel10k-config";
      src = ./powerlevel10k-config;
      file = "p10k.zsh";
    }
  ];
}; }
