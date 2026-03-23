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
        "chat.agent.maxRequests" = 1000;
        "github.copilot.chat.agent.autoFix" = true;
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
        "github.copilot.chat.copilotDebugCommand.enabled" = true;

        # GitHub Copilot - MCP & Features
        "chat.mcp.gallery.enabled" = true;
        "chat.mcp.discovery.enabled" = true;
        "chat.customAgentInSubagent.enabled" = true;
        "chat.useAgentSkills" = true;
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
          id = "context7_api_key";
          description = "Context7 API Key";
          password = true;
        }
      ];
      servers = {
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
