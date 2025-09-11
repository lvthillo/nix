{pkgs, ...}: let
  # Use official nixpkgs MCP servers where available
  github-mcp = pkgs.github-mcp-server;

  # For servers not in nixpkgs, create minimal Nix wrappers
  mcp-atlassian-server = pkgs.writeShellScriptBin "mcp-atlassian-server" ''
    exec ${pkgs.docker}/bin/docker run -i --rm \
      -e JIRA_PROJECTS_FILTER \
      -e JIRA_URL \
      -e JIRA_PERSONAL_TOKEN \
      -e ENABLED_TOOLS \
      ghcr.io/sooperset/mcp-atlassian:latest "$@"
  '';

  # Create Nix wrappers for npm-based servers for consistency
  context7-mcp = pkgs.writeShellScriptBin "context7-mcp" ''
    exec ${pkgs.nodejs}/bin/npx -y @upstash/context7-mcp "$@"
  '';
in {
  # Install MCP servers as packages
  home.packages = [
    github-mcp
    mcp-atlassian-server
    context7-mcp
    pkgs.nodejs # Ensure nodejs is available for npm-based servers
  ];

  # Export server paths for use in other modules following NixOS conventions
  _module.args.mcpServers = {
    github = github-mcp;
    atlassian = mcp-atlassian-server;
    context7 = context7-mcp;
  };
}
