{pkgs, ...}: {
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
        # Use Ghostty as the external terminal
        "terminal.external.osxExec" = "Ghostty.app";

        # Visual Studio Code
        "workbench.startupEditor" = "none";
        "security.workspace.trust.enabled" = false;
        "terminal.integrated.showOnStartup" = "always";

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
        "gitlens.graph.showOnStartup" = false;

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

        # GitHub Copilot - Inline Suggestions & Code Editing
        "github.copilot.enable" = {
          "*" = true;
          "plaintext" = false;
          "markdown" = true;
          "scminput" = false;
        };
        "github.copilot.nextEditSuggestions.enabled" = true;
        "github.copilot.nextEditSuggestions.fixes" = true;
        "github.copilot.editor.enableCodeActions" = true;
        "github.copilot.renameSuggestions.triggerAutomatically" = true;
        "editor.inlineSuggest.edits.allowCodeShifting" = "always";
        "editor.inlineSuggest.edits.renderSideBySide" = "auto";
        "editor.inlineSuggest.syntaxHighlightingEnabled" = true;
        "editor.inlineSuggest.minShowDelay" = 0;

        # GitHub Copilot - Agent Mode & Tools
        "chat.agent.enabled" = true;
        "chat.agent.maxRequests" = 500;
        "github.copilot.chat.agent.autoFix" = true;
        "github.copilot.chat.agent.runTasks" = true;
        "github.copilot.chat.agent.thinkingTool" = true;
        "chat.tools.terminal.enableAutoApprove" = true;
        "chat.tools.terminal.autoApprove" = {
          "rm" = false;
          "rmdir" = false;
          "del" = false;
          "kill" = false;
          "chmod" = false;
          "chown" = false;
          "eval" = false;
        };

        # GitHub Copilot - Chat & Context
        "github.copilot.chat.codesearch.enabled" = true;
        "github.copilot.chat.edits.suggestRelatedFilesFromGitHistory" = true;
        "github.copilot.chat.editor.temporalContext.enabled" = true;
        "github.copilot.chat.reviewSelection.enabled" = true;
        "chat.checkpoints.enabled" = true;

        # GitHub Copilot - Custom Instructions & Prompt Files
        "github.copilot.chat.codeGeneration.useInstructionFiles" = true;
        "chat.instructionsFilesLocations" = {
          ".github/instructions" = true;
        };
        "chat.promptFilesLocations" = {
          ".github/prompts" = true;
        };

        # GitHub Copilot - Debugging
        "github.copilot.chat.startDebugging.enabled" = true;
        "github.copilot.chat.copilotDebugCommand.enabled" = true;

        # GitHub Copilot - MCP & Features
        "chat.mcp.gallery.enabled" = true;
        "chat.mcp.discovery.enabled" = true;
        "chat.customAgentInSubagent.enabled" = true;
        "chat.todoListTool.writeOnly" = true;
        "chat.useAgentSkills" = true;
        "chat.hooks.enabled" = true;
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
        # {
        #   type = "promptString";
        #   id = "jira_token";
        #   description = "JIRA Personal Access Token";
        #   password = true;
        # }
        # {
        #   type = "promptString";
        #   id = "jira_url";
        #   description = "JIRA URL";
        #   password = false;
        # }
        {
          type = "promptString";
          id = "context7_api_key";
          description = "Context7 API Key";
          password = true;
        }
      ];
      servers = {
        # github = {
        #   command = "github-mcp-server";
        #   args = ["stdio"];
        #   env = {
        #     GITHUB_PERSONAL_ACCESS_TOKEN = "\${input:github_token}";
        #     GITHUB_TOOLSETS = "dependabot,context,pull_requests,repos";
        #   };
        # };
        # mcp-atlassian = {
        #   command = "mcp-atlassian-server";
        #   env = {
        #     JIRA_URL = "\${input:jira_url}";
        #     JIRA_PERSONAL_TOKEN = "\${input:jira_token}";
        #     JIRA_PROJECTS_FILTER = "DEVEX";
        #     ENABLED_TOOLS = "jira_search,jira_get_issue,jcp_get_worklog,jira_get_board_issues,jira_get_sprint_issues,jira_get_issue_link_types,jira_get_user_profile,jira_create_issue,jira_update_issue,jira_add_comment,jira_transition_issue,jira_create_issue_link,jira_remove_issue_link";
        #   };
        # };
        context7 = {
          type = "stdio";
          command = "context7-mcp";
          env = {
            CONTEXT7_API_KEY = "\${input:context7_api_key}";
          };
        };
      };
    };
  };
}
