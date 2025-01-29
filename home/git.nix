{
  lib,
  userfullname,
  useremail,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistisngGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = userfullname;
    userEmail = useremail;

    includes = [
      {
        # use a different config for work
        path = "~/dpg/.ssh/.gitconfig";
        condition = "gitdir:~/dpg/";
      }
    ];

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      core.editor = "vim";
      gpg.format = "openpgp";
    };

    signing = {
      key = "55F15386881C1246";
      signByDefault = true;
    };

    delta = {
      enable = true;
      options = {
        features = "side-by-side";
      };
    };

    aliases = {
      # common aliases
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      amend = "commit --amend -m";

      # aliases for submodule
      update = "submodule update --init --recursive";
      foreach = "submodule foreach";
    };
  };

  home.file = {
    "dpg/.ssh/.gitconfig" = {
      text = ''
        [core]
          sshCommand = ssh -i ~/dpg/.ssh/id_ed25519

        [user]
          email = lorenz.vanthillo@persgroep.net
      '';
    };
  };
}
