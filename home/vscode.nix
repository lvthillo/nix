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
      };
    };

    mutableExtensionsDir = true;
  };
}
