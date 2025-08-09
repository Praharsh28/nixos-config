{ config, pkgs, ... }:

{
  # System utilities and security tools
  environment.systemPackages = with pkgs; [
    # System monitoring and diagnostics
    s-tui
    lm_sensors
    smartmontools
    
    # Disk utilities
    ncdu
    duf
    
    # Network utilities
    iperf
    bandwhich
    
    # Security tools
    keepassxc
    age
    
    # File synchronization
    rclone
    
    # Terminal utilities
    tmux
    fzf
    ripgrep
    fd
    bat
    eza
    
    # System backup
    timeshift
    restic
    
    # Remote access
    openssh
    remmina
  ];
  
  # Enable firewall with sensible defaults
  networking.firewall = {
    enable = true;
    allowPing = true;
  };
}
