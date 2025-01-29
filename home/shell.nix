{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = false;

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "aws" "terraform" "gh" "nvm" "pyenv" "sublime"];
      theme = "agnoster";
    };

    shellAliases = {
      sts = "aws sts get-caller-identity";
      tfapply = "terraform apply";
      tfplan = "terraform plan";
      czm = "cz commit";
      devex-prod = "export AWS_PROFILE=devex-prod-admin";
      devex-non-prod = "export AWS_PROFILE=devex-non-prod-admin";
      ll = "ls -l";
    };

    initExtra = ''
      # Node Version Manager
      [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
      [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
    '';

    profileExtra = ''
      eval "$(brew shellenv)"
    '';

    sessionVariables = {
      # TODO
      PATH = "$PATH:$HOME/go/bin";
      GOPATH = "$HOME/go";
      NVM_DIR = "$HOME/.nvm";
      AWS_CA_BUNDLE = "/opt/homebrew/etc/ca-certificates/cert.pem";
      #NODE_EXTRA_CA_CERTS = "$HOME/.zcli/zscaler_root.pem";
    };
  };
}
