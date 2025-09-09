{ user, ... }: let
  sshDir = "${user.homePath}/.ssh";
in {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        hashKnownHosts = false;
        userKnownHostsFile = "${sshDir}/known_hosts";
      };
      "github.com" = {
        identitiesOnly = true;
        identityFile = [ "${sshDir}/id_ed25519" ];
      };
      "your-storagebox.de" = {
        identitiesOnly = true;
        identityFile = [ "${sshDir}/id_rsa" ];
      };
    };
  };
}
