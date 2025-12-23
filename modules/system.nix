{
  pkgs,
  username,
  ...
}:
###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#  Incomplete list of macOS `defaults` commands :
#    https://github.com/yannbertrand/macos-defaults
#
###################################################################################
{
  system = {
    stateVersion = 6;

    defaults = {
      dock = {
        show-recents = false;

        persistent-apps = [
          "/System/Applications/Apps.app"
          "/Applications/Firefox.app"
          "/Applications/Slack.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
          "/Applications/iTerm.app"
          "/Applications/Sublime Text.app"
          "/Applications/Spotify.app"
        ];

        # hot corners
        wvous-br-corner = 1; # bottom-right - disabled

        # icon size
        tilesize = 64;
      };

      # customize settings that not supported by nix-darwin directly
      # Incomplete list of macOS `defaults` commands :
      #   https://github.com/yannbertrand/macos-defaults
      NSGlobalDomain = {
        # `defaults read NSGlobalDomain "xxx"`
        NSAutomaticSpellingCorrectionEnabled = false;
        AppleInterfaceStyle = "Dark";
      };

      # Customize settings that not supported by nix-darwin directly
      # see the source code of this project to get more undocumented options:
      #    https://github.com/rgcr/m-cli
      #
      # All custom entries can be found by running `defaults read` command.
      # or `defaults read xxx` to read a specific domain.
      CustomUserPreferences = {
        "com.apple.finder" = {
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        # "com.apple.screensaver" = {
        #   # Require password immediately after sleep or screen saver begins
        #   askForPassword = 1;
        #   askForPasswordDelay = 0;
        # };
      };

      menuExtraClock = {
        ShowSeconds = true;
      };
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # Fix zsh completion insecure files automatically on system activation
  system.activationScripts.fixZshCompletions.text = ''
    echo "Checking zsh completion file permissions..."
    if [ -f /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion ]; then
      chown ${username} /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion 2>/dev/null || true
      chown ${username} /Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion 2>/dev/null || true
      chown ${username} /opt/homebrew/share/zsh/site-functions/_docker* 2>/dev/null || true
      echo "✓ Fixed Docker zsh completion file ownership"
    fi
  '';

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };
}
