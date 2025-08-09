{ config, pkgs, lib, ... }:

{
  # Terminal packages
  home.packages = with pkgs; [
    starship       # Modern prompt
    # Individual nerd fonts instead of the full package
    nerd-fonts.jetbrains-mono  # JetBrains Mono with icons
    nerd-fonts.fira-code       # FiraCode with icons
    lsd           # Modern ls replacement
    bat           # Better cat with syntax highlighting
  ];

  # Terminal enhancements
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = ["--cmd cd"];
  };

  # Optimized Zsh configuration
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      # No theme - using starship instead
      theme = "";
      plugins = [
        "git"
        "z"
        "sudo"
        "docker"
        "kubectl"
        "history-substring-search"
        "colored-man-pages"
        "command-not-found"
        "zsh-interactive-cd"
      ];
    };

    # Custom aliases for productivity
    shellAliases = {
      ls = "lsd";
      ll = "lsd -la";
      la = "lsd -la";
      lt = "lsd --tree";
      cat = "bat";
      ".." = "cd ..";
      "..." = "cd ../..";
      cls = "clear";
      grep = "grep --color=auto";

      # Nix shortcuts
      nrs = "sudo nixos-rebuild switch";
      nrt = "sudo nixos-rebuild test";
      nrb = "sudo nixos-rebuild boot";
      nfu = "nix flake update";

      # Git shortcuts
      gst = "git status";
      gco = "git checkout";
      gcb = "git checkout -b";
      gp = "git push";
      gl = "git pull";

      # System monitoring
      htop = "btop";
      top = "btop";
    };

    # Additional zsh options
    initContent = lib.mkOrder 500 ''
      # History settings
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_IGNORE_SPACE
      setopt HIST_VERIFY
      setopt SHARE_HISTORY

      # Directory navigation
      setopt AUTO_CD
      setopt AUTO_PUSHD
      setopt PUSHD_IGNORE_DUPS

      # Completion improvements
      setopt COMPLETE_ALIASES
      setopt COMPLETE_IN_WORD
      setopt ALWAYS_TO_END

      # Better completion matching
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

      # Colored completion
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

      # Custom key bindings
      bindkey "^[[A" history-substring-search-up
      bindkey "^[[B" history-substring-search-down

      # Enable starship prompt
      eval "$(starship init zsh)"
    '';
  };

  # Starship prompt configuration
  programs.starship = {
    enable = true;
    # Use the custom config file we created
    settings = builtins.fromTOML (builtins.readFile ../starship.toml);
  };
}
