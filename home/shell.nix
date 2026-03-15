{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
    ];
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Macchiato";
    };
    themes = {
      "Catppuccin Macchiato" = {
        src = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Macchiato.tmTheme";
          name = "catppuccin-macchiato.tmTheme";
          sha256 = "01jspd4qq7lw0g891hilladvas8p2q67icrgv1lyaw5rapv9000i";
        };
      };
    };
  };

  home.shellAliases = {
    sts = "aws sts get-caller-identity";
    tfapply = "terraform apply";
    tfplan = "terraform plan";
    czm = "cz commit";
    devex-prod = "export AWS_PROFILE=devex-prod-admin";
    devex-non-prod = "export AWS_PROFILE=devex-non-prod-admin";
    ll = "eza -l";
    la = "eza -la";
    lt = "eza --tree --level=2";
    cat = "bat --paging=never";
    nix-sync = "(cd ~/nix; git pull; just deploy)";
    nix-update = "(cd ~/nix; just up; git add flake.lock; git commit -m 'Update flake.lock'; git push; just deploy)";
  };

  home.sessionVariables = {
    ZSH_DISABLE_COMPFIX = "true";
    VOLTA_HOME = "$HOME/.volta";
    GOPATH = "$HOME/go";
    AWS_CA_BUNDLE = "/opt/homebrew/etc/ca-certificates/cert.pem";
    JAVA_HOME = "/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home";
    NODE_EXTRA_CA_CERTS = "$HOME/.zcli/zscaler_root.pem";
  };

  home.sessionPath = [
    "$VOLTA_HOME/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "/Library/TeX/texbin"
  ];
}
