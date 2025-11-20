{
  lib,
  userfullname,
  useremail,
  ...
}: {
  home.activation.removeExistisngGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = userfullname;
        email = useremail;
      };

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      core.editor = "vim";
      gpg.format = "openpgp";

      alias = {
        br = "branch";
        co = "checkout";
        st = "status";
        cm = "commit -m";
        ca = "commit -am";
        dc = "diff --cached";
        amend = "commit --amend -m";
        update = "submodule update --init --recursive";
        foreach = "submodule foreach";
      };
    };

    includes = [
      {
        path = "~/dpg/.ssh/.gitconfig";
        condition = "gitdir:~/dpg/";
      }
    ];

    signing = {
      key = "55F15386881C1246";
      signByDefault = true;
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
