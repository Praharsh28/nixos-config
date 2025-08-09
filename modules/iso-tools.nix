{ config, pkgs, ... }:

{
  # Tools for working with ISO files and disk images
  environment.systemPackages = with pkgs; [
    # ISO mounting and management
    fuseiso
    archivemount
    
    # Disk image tools
    qemu
    
    # File system tools
    dosfstools
    ntfs3g
    exfat
    
    # Additional utilities
    udiskie  # Auto-mounting removable media
    udisks  # D-Bus service for disk management
  ];
  
  # Enable FUSE for user mounts
  programs.fuse = {
    userAllowOther = true;
  };
  
  # Add your user to the disk group for better device access
  users.users.enigma.extraGroups = [ "disk" ];
}
