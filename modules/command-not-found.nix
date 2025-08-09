{ config, pkgs, lib, ... }:

{
  # Enable nix-index for better command-not-found experience
  programs.nix-index = {
    enable = true;
    # Don't enable shell integrations as they conflict with command-not-found
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  # Prebuilt nix-index database and comma for ad-hoc commands
  programs.nix-index-database.enable = true;
  programs.nix-index-database.comma.enable = true;

  # Configure command-not-found to use nix-index database
  programs.command-not-found = {
    enable = true;
    # Use the nix-index database
    dbPath = lib.mkDefault "/var/lib/nixos/command-not-found.db";
  };
}
