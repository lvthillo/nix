{
  config,
  nix-vscode-extensions,
  ...
}: {
  environment.variables.EDITOR = "code --wait";

  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      "Xcode" = 497799835;
      "Slack" = 803453959;
      "The Unarchiver" = 425424353;
      "Boop" = 1518425043;
    };

    # `brew install`
    brews = [
      "just"
      "volta"
      "awscli"
      "folderify"
      "sops"
      "tfenv"
      "terraform-docs"
      "gh"
      "aws-sso-util"
      "aws-sam-cli"
      "cfn-lint"
      "commitizen"
      "black"
      "pre-commit"
      "make"
      "wget"
      "hugo"
      "pinentry-mac" # gpg dependency
      "gnupg"
      "telnet"
      "pylint"
      "dagger"
      "act"
      "mdformat"
      "eza"
      "bat"
      "goreleaser"
      "jfrog-cli"
      "git-filter-repo"
      "openjdk"
      "maven"
      "gradle"
      "pipx"
    ];

    # `brew install --cask`
    casks = [
      "firefox"
      "discord"
      "spotify"
      "postgres-unofficial"
      "sublime-text"
      "iterm2"
      "session-manager-plugin"
      "mactex"
      "postman"
      "shottr"
      "docker-desktop"
      "windows-app"
      # Remove below after a while
      # Necessary for testing the license server connection
      "intellij-idea"
    ];

    # https://github.com/zhaofengli/nix-homebrew/issues/5#issuecomment-1878798641
    taps = builtins.attrNames config.nix-homebrew.taps;
  };

  nixpkgs = {
    # Allow unfree packages
    config.allowUnfree = true;

    overlays = [
      nix-vscode-extensions.overlays.default
    ];
  };
}
