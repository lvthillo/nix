{pkgs, ...}: {
  programs.gpg = {
    enable = true;
  };

  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program /opt/homebrew/bin/pinentry-mac
    enable-ssh-support
  '';

  home.sessionVariables = {
    GPG_TTY = "$(tty)";
  };
}
