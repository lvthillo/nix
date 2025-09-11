{config, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        identityFile = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
        addKeysToAgent = "yes";
        identitiesOnly = true;
      };
    };
  };
}
