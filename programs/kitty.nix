{ pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;

    darwinLaunchOptions = [
      "--single-instance"
    ];

    shellIntegration = {
      mode = "no-rc no-cursor no-title";

      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    settings = {
      "enable_audio_bell" = "no";

      "background_opacity" = "0.9";

      "remember_window_size" = "no";
      "initial_window_width" = "120c";
      "initial_window_height"= "40c";

      # Darwin specific
      "macos_option_as_alt" = "both";
      "macos_quit_when_last_window_closed" = "no";
    };

    # Links back to a kitty.app that gets provided outside of nix
    package = pkgs.runCommand "kitty-link" {} ''
      mkdir -p $out
      cd $out

      # Applications
      mkdir Applications
      ln -s /Applications/kitty.app Applications/kitty.app
      
      # bin
      ln -s /Applications/kitty.app/Contents/MacOS bin

      # share
      mkdir share
      cd share
      mkdir bash-completion fish man zsh
      ln -s /Applications/kitty.app/Contents/Resources/kitty/shell-integration/bash bash-completion/completions
      ln -s /Applications/kitty.app/Contents/Resources/kitty/shell-integration/fish fish/vendor_completions.d
      ln -s /Applications/kitty.app/Contents/Resources/man/man1 man/man1
      ln -s /Applications/kitty.app/Contents/Resources/kitty/shell-integration/zsh zsh/site-functions
    '';
  };
}
