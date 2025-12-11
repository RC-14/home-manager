{ pkgs, yazi-plugins-repo, ... }: let
  # Shared logic for the two functions beneath
  makeUsePluginsFunc = parentDir: pluginNames: (
    builtins.listToAttrs (map 
      (name: {
        inherit name;
        value = "${parentDir}/${name}.yazi";
      })
      pluginNames
    )
  );

  # Make functions to easily add plugins from a list by name
  useOfficialPlugins = makeUsePluginsFunc yazi-plugins-repo;
  useCustomPlugins = makeUsePluginsFunc ./lua;
in {
  programs.yazi = {
    enable = true;
    package = (pkgs.yazi.override {
      _7zz = pkgs._7zz-rar; # Support for RAR extraction
    });

    shellWrapperName = "yy";

    settings = {
      mgr = {
        ratio = [2 4 3];
        sort_by = "natural";
        sort_translit = false;
        scrolloff = 10;
      };

      preview = let
        maxImageSize = 8192;
      in {
        max_width = maxImageSize;
        max_height = maxImageSize;
      };

      plugin = {
        prepend_fetchers = [
          { id = "git"; name = "*"; run = "git"; }
          { id = "git"; name = "*/"; run = "git"; }
        ];
      	prepend_previewers = [
          # Fix weird behavior when switching files
      	  { mime = "image/{jpeg,png,webp}"; run = "zoom 0"; }

      	  # { mime = "image/{jpeg,png,webp}"; run = "max-sized-img-previews"; }
      	];
      };
    };

    keymap = {
      mgr = {
        prepend_keymap = [
          # Chmod
          { on = [ "c" "m" ]; run = "plugin chmod"; desc = "Chmod on selected files";}

          # Confirm Quit
          { on = "q"; run = "plugin confirm-quit"; desc = "Quit the process but ask first if multiple tabs are open"; }

          # Mount
          { on = "M"; run = "plugin mount"; desc = "Open the Interface of the Mount Plugin"; }

          # Smart Paste
          { on = "p"; run = "plugin smart-paste"; desc = "Paste into the hovered directory or CWD"; }

          # Toggle Pane
          { on = [ "F" "r" ]; run = "plugin toggle-pane reset";       desc = "Reset View Sizes";              }
          { on = [ "F" "p" ]; run = "plugin toggle-pane max-parent";  desc = "Toggle Fullscreen for Parent";  }
          { on = [ "F" "c" ]; run = "plugin toggle-pane max-current"; desc = "Toggle Fullscreen for Current"; }
          { on = [ "F" "f" ]; run = "plugin toggle-pane max-preview"; desc = "Toggle Fullscreen for Preview"; }

          # Zoom
          { on = "+"; run = "plugin zoom 1";  desc = "Zoom in on current Preview";  }
          { on = "="; run = "plugin zoom -1"; desc = "Zoom out on current Preview"; }
        ];
      };
    };

    # The config actually gets loaded from a plugin so that I can split it into multiple files
    initLua = ''require "config"'';

    plugins = (useCustomPlugins [
      #
      # My custom Plugins from the lua directory (may be copy pasted from somewhere)
      #
      "confirm-quit"
      # "max-sized-img-previews"

      # My actual config
      "config"
    ]) // (useOfficialPlugins [
      #
      # Plugins from the official repo
      #
      "chmod"
      "full-border"
      # "git" # No idea how to get this working
      "mount"
      "smart-paste"
      "toggle-pane"
      "zoom"

      # No functionality - for development only
      "types"
    ]);
    extraPackages = with pkgs; [];
  };
}
