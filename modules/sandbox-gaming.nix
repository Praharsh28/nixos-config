{ config, pkgs, ... }:

{
  # Sandbox gaming setup for NixOS 25.05 "Warbler"

  # Core sandbox tools
  environment.systemPackages = with pkgs; [
    # Primary sandboxing tools
    bubblewrap  # Low-level sandboxing used by Flatpak
    firejail    # Application sandbox with gaming profiles

    # Flatpak ecosystem (recommended for gaming)
    flatpak     # Application sandboxing platform

    # Utilities for better sandbox integration
    xdg-dbus-proxy  # D-Bus proxy for sandboxed applications
    bindfs          # Bind filesystem tool for sandboxes
  ];

  # Enable Flatpak service
  services.flatpak.enable = true;

  # Enable user namespaces (required for unprivileged sandboxing)
  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
    "kernel.yama.ptrace_scope" = 0;  # Allow ptrace for debugging in sandboxes
  };

  # Ensure hardware acceleration works in sandboxes
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Required for 32-bit games
  };

  # Add user to necessary groups
  users.users.enigma.extraGroups = [ "input" ];

  # Note: Steam is already configured in gaming.nix
  # The existing configuration already has proper sandbox integration
}
