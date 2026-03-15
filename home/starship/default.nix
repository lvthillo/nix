{lib, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = lib.recursiveUpdate
      (builtins.fromTOML (builtins.readFile ./presets/nerd-font-symbols.toml))
      {
        palette = "catppuccin_macchiato";

        palettes.catppuccin_macchiato = {
          rosewater = "#f4dbd6";
          flamingo = "#f0c6c6";
          pink = "#f5bde6";
          mauve = "#c6a0f6";
          red = "#ed8796";
          maroon = "#ee99a0";
          peach = "#f5a97f";
          yellow = "#eed49f";
          green = "#a6da95";
          teal = "#8bd5ca";
          sky = "#91d7e3";
          sapphire = "#7dc4e4";
          blue = "#8aadf4";
          lavender = "#b7bdf8";
          text = "#cad3f5";
          subtext1 = "#b8c0e0";
          subtext0 = "#a5adcb";
          overlay2 = "#939ab7";
          overlay1 = "#8087a2";
          overlay0 = "#6e738d";
          surface2 = "#5b6078";
          surface1 = "#494d64";
          surface0 = "#363a4f";
          base = "#24273a";
          mantle = "#1e2030";
          crust = "#181926";
        };

        format = lib.concatStrings [
          "$directory"
          "$git_branch"
          "$golang"
          "$java"
          "$nodejs"
          "$python"
          "$terraform"
          "$nix_shell"
          "$aws"
          "$cmd_duration"
          "$line_break"
          "$character"
        ];

        directory = {
          style = "bold peach";
          truncation_length = 5;
          truncate_to_repo = false;
        };

        git_branch = {
          style = "bold green";
          format = "on [$symbol$branch]($style) ";
        };

        golang = {
          style = "teal";
          format = "via [$symbol]($style) ";
        };

        java = {
          style = "teal";
          format = "via [$symbol]($style) ";
        };

        nodejs = {
          style = "teal";
          format = "via [$symbol]($style) ";
        };

        python = {
          style = "teal";
          format = "via [$symbol]($style) ";
        };

        terraform = {
          style = "teal";
          format = "via [$symbol($workspace)]($style) ";
        };

        nix_shell = {
          style = "lavender";
          format = "via [$symbol]($style) ";
        };

        aws = {
          style = "blue";
          format = "on [$symbol$region]($style) ";
        };

        cmd_duration = {
          style = "yellow";
          format = "took [$duration]($style) ";
          min_time = 2000;
        };

        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[>](bold red)";
        };

        os = {
          disabled = true;
        };

        docker_context = {
          disabled = true;
        };

        git_status = {
          disabled = true;
        };

        username = {
          disabled = true;
        };
      };
  };
}
