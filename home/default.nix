{
  username,
  pkgs,
  ...
}: let
  mcpServers = import ./mcp.nix {inherit pkgs;};
in {
  # import sub modules
  imports = [
    ./shell.nix
    ./core.nix
    ./vscode.nix
    ./git.nix
    ./starship
    ./ghostty.nix
    ./ssh.nix
    ./go.nix
    ./direnv.nix
    ./gpg.nix
  ];

  # Install MCP servers
  home.packages = with mcpServers; [
    #github
    #atlassian
    context7
    pkgs.nodejs # For npm-based servers
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.05";

    # home-manager master temporarily lags nixpkgs-unstable after a release
    # (HM claims 26.05 while nixpkgs-unstable has rolled to 26.11). Suppress
    # the warning; remove once HM master bumps to 26.11.
    enableNixpkgsReleaseCheck = false;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
