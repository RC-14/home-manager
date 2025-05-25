{ pkgs, lib, ... }: {
  launchd.agents.wireproxy = {
    enable = true;
    config = {
      AbandonProcessGroup = true;
      RunAtLoad = true;

      Program = lib.getExe (pkgs.writeShellApplication {
        name = "wireproxy-launcher";
        runtimeInputs = with pkgs; [ wireproxy ];
        text = ''
          [ ! -d "$HOME/.config/wireproxy/" ] && exit
  
          pushd "$HOME/.config/wireproxy/"
  
          for FILE in *.conf; do
            [ ! -d "$FILE" ] && wireproxy -d -c "$(pwd)/$FILE"
          done
  
          popd
        '';
      });
    };
  };
}
