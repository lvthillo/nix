{pkgs}: {
  # GitHub MCP server (official nixpkgs package)
  github = pkgs.github-mcp-server;

  # Atlassian MCP server (Docker-based)
  atlassian = pkgs.writeShellScriptBin "mcp-atlassian-server" ''
    exec ${pkgs.docker}/bin/docker run -i --rm \
      -e JIRA_PROJECTS_FILTER \
      -e JIRA_URL \
      -e JIRA_PERSONAL_TOKEN \
      -e ENABLED_TOOLS \
      ghcr.io/sooperset/mcp-atlassian:latest "$@"
  '';

  # Context7 MCP server (npm-based)
  context7 = pkgs.writeShellScriptBin "context7-mcp" ''
    exec ${pkgs.nodejs}/bin/npx -y @upstash/context7-mcp "$@"
  '';
}
