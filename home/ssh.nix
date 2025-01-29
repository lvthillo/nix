{...}: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityFile ~/.ssh/id_ed25519
        AddKeysToAgent yes
    '';
  };
}
