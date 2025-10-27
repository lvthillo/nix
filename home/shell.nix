{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = false;

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "aws" "terraform" "gh" "nvm" "sublime"];
      theme = "agnoster";
    };

    shellAliases = {
      sts = "aws sts get-caller-identity";
      tfapply = "terraform apply";
      tfplan = "terraform plan";
      czm = "cz commit";
      gco = "git checkout";
      devex-prod = "export AWS_PROFILE=devex-prod-admin";
      devex-non-prod = "export AWS_PROFILE=devex-non-prod-admin";
      ll = "ls -l";
    };
  };

  home.sessionVariables = {
    VOLTA_HOME = "$HOME/.volta";
    GOPATH = "$HOME/go";
    AWS_CA_BUNDLE = "/opt/homebrew/etc/ca-certificates/cert.pem";
    JAVA_HOME = "/opt/homebrew/Cellar/openjdk/24.0.2/libexec/openjdk.jdk/Contents/Home/";
    NODE_EXTRA_CA_CERTS = "$HOME/.zcli/zscaler_root.pem";
  };

  home.sessionPath = [
    "$VOLTA_HOME/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "/Library/TeX/texbin"
  ];
}
