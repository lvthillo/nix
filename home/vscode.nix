{
  pkgs,
  mcpServers,
  ...
}: {
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-marketplace;
      with pkgs.vscode-marketplace-release; [
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        eamodio.gitlens
        jnoortheen.nix-ide
        hashicorp.terraform
        amazonwebservices.aws-toolkit-vscode
        kddejong.vscode-cfn-lint
        ms-python.python

        # Catppuccin
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons

        # GitHub Copilot
        github.copilot
        github.copilot-chat
      ];
      userSettings = {
        # Use iTerm2 as the terminal
        "terminal.external.osxExec" = "iTerm.app";

        # Visual Studio Code
        "workbench.startupEditor" = "none";
        "security.workspace.trust.enabled" = false;

        # Prettier
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnSave" = true;
        "prettier.requireConfig" = true;

        # ESLint
        "editor.codeActionsOnSave" = {
          "source.fixAll" = "explicit";
        };

        # GitLens
        "gitlens.codeLens.enabled" = false;

        # Terraform
        "[terraform]" = {
          "editor.defaultFormatter" = "hashicorp.terraform";
          "editor.formatOnSave" = true;
          "editor.formatOnSaveMode" = "file";
        };
        "[terraform-vars]" = {
          "editor.defaultFormatter" = "hashicorp.terraform";
          "editor.formatOnSave" = true;
          "editor.formatOnSaveMode" = "file";
        };

        # Catppuccin
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.iconTheme" = "catppuccin-macchiato";

        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = ["alejandra"];
            };
          };
        };
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.formatOnSave" = true;
        };

        # GitHub Copilot
        "github.copilot.enable" = {
          "*" = true;
          "plaintext" = false;
          "markdown" = true;
          "scminput" = false;
        };
        "github.copilot.nextEditSuggestions.enabled" = true;

        # Copilot Beast Mode
        "chat.tools.autoApprove" = true;
        "chat.agent.maxRequests" = 100;
        "chat.mcp.enabled" = true;
      };
    };

    mutableExtensionsDir = true;
  };

  # VS Code-specific MCP configuration file
  home.file."Library/Application Support/Code/User/mcp.json" = {
    text = builtins.toJSON {
      inputs = [
        {
          type = "promptString";
          id = "github_token";
          description = "GitHub Personal Access Token";
          password = true;
        }
        {
          type = "promptString";
          id = "jira_token";
          description = "JIRA Personal Access Token";
          password = true;
        }
        {
          type = "promptString";
          id = "jira_url";
          description = "JIRA URL";
          password = false;
        }
        {
          type = "promptString";
          id = "context7_api_key";
          description = "Context7 API Key";
          password = true;
        }
      ];
      servers = {
        github = {
          command = "${mcpServers.github}/bin/github-mcp-server";
          args = ["stdio"];
          env = {
            GITHUB_PERSONAL_ACCESS_TOKEN = "\${input:github_token}";
            GITHUB_TOOLSETS = "dependabot,context,pull_requests,repos";
          };
        };
        mcp-atlassian = {
          command = "${mcpServers.atlassian}/bin/mcp-atlassian-server";
          env = {
            JIRA_URL = "\${input:jira_url}";
            JIRA_PERSONAL_TOKEN = "\${input:jira_token}";
            JIRA_PROJECTS_FILTER = "DEVEX";
            ENABLED_TOOLS = "jira_search,jira_get_issue,jira_get_worklog,jira_get_board_issues,jira_get_sprint_issues,jira_get_issue_link_types,jira_get_user_profile,jira_create_issue,jira_update_issue,jira_add_comment,jira_transition_issue,jira_create_issue_link,jira_remove_issue_link";
          };
        };
        context7 = {
          type = "stdio";
          command = "${mcpServers.context7}/bin/context7-mcp";
          env = {
            CONTEXT7_API_KEY = "\${input:context7_api_key}";
          };
        };
      };
    };
  };
}
