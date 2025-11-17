{ lib, pkgs, ... }: {
  programs.mpv = {
    enable = true;
  
    bindings = {
      # Skip anime opening
      "Shift+s" = "seek +85";
      # Next Chapter
      "Alt+right" = "add chapter 1";
      # Previous Chapter / Start of current Chapter
      "Alt+left" = "add chapter -1";
    };
  
    config = {
      fullscreen = true;
  
      # Fuzzy subtitle finding
      sub-auto = "fuzzy";
  
      # Use GPU-accelerated video output by default
      vo = "libmpv";
      # Use hardware video decoding
      hwdec = "yes";
  
      # Treat right Alt key as Alt not Alt-Gr
      input-right-alt-gr = "no";
  
      # Screenshot config
      screenshot-format = "png";
      screenshot-directory = "~/Pictures/Screenshots/";
    };

    # Links back to a mpv.app that gets provided outside of nix
    package = pkgs.runCommand "mpv-link" {} ''
      mkdir -p $out
      cd $out

      # bin
      mkdir bin
      ln -s /opt/homebrew/bin/mpv bin/mpv
      # I don't know where to find the rest if it's even there and its not important to me
    '';
  };
}
