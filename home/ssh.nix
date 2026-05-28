{config, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        IdentityFile = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
        AddKeysToAgent = "yes";
        IdentitiesOnly = true;
        UseKeychain = "yes";
      };
    };
  };
}
