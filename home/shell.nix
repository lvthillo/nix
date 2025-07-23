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

    profileExtra = ''
      eval "$(brew shellenv)"
      eval "$(pyenv init --path)"
      eval "$(/usr/libexec/path_helper)"
    '';
  };

  home.sessionVariables = {
    VOLTA_HOME = "$HOME/.volta";
    GOPATH = "$HOME/go";
    PYENV_ROOT = "$HOME/.pyenv";
    AWS_CA_BUNDLE = "/opt/homebrew/etc/ca-certificates/cert.pem";
    JAVA_HOME = "/opt/homebrew/Cellar/openjdk/24.0.1/libexec/openjdk.jdk/Contents/Home/";
  };

  home.sessionPath = [
    "$VOLTA_HOME/bin"
    "$PYENV_ROOT/bin"
    "$HOME/go/bin"
    "/Library/TeX/texbin"
  ];
}
