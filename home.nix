{ config, pkgs, lib, ... }:

{
  imports = [
    # Import the terminal module
    ./modules/terminal.nix
  ];

  home.username = "enigma";
  home.homeDirectory = "/home/enigma";

  # Enable font configuration
  fonts.fontconfig.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    userName = "enigma";
    userEmail = "drpraharsh@gmail.com"; # Change this to your email

    extraConfig = {
      init.defaultBranch = "main";
      push.default = "simple";
      pull.rebase = true;
      core.editor = "vim";

      # Better diff and merge tools
      diff.tool = "vimdiff";
      merge.tool = "vimdiff";

      # Improved git log format
      alias = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        st = "status -s";
        co = "checkout";
        br = "branch";
        ci = "commit";
        df = "diff";
        dc = "diff --cached";
      };
    };
  };

  home.stateVersion = "25.05";
}
