{ user, ... }: let
  sshDir = "${user.homePath}/.ssh";
in {
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    serverAliveInterval = 30;
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [ "${sshDir}/id_ed25519" ];
      };
    };
  };
}
