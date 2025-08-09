{ config, pkgs, ... }:

{
  # Torrent clients and tools
  environment.systemPackages = with pkgs; [
    # GUI Torrent Clients
    qbittorrent  # Modern, feature-rich Qt client
    transmission  # Transmission includes both GUI and CLI
    
    # CLI Torrent Clients
    aria2  # Lightweight multi-protocol download utility
    
    # Torrent Search and Management
    jackett  # API Support for torrent trackers
    
    # Network Tools
    socat  # Multipurpose relay
    netcat  # TCP/IP swiss army knife
  ];
  
  # Open ports for torrent clients
  networking.firewall = {
    # Default ports for common torrent clients
    allowedTCPPorts = [ 
      51413  # Transmission default
      8999   # qBittorrent WebUI default
      9091   # Transmission WebUI default
    ];
    allowedUDPPorts = [ 
      51413  # Transmission default
    ];
  };
}
