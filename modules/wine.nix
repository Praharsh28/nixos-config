{ config, pkgs, ... }:

{
  # Wine configuration for both 32-bit and 64-bit support
  environment.systemPackages = with pkgs; [
    # Wine with both 32-bit and 64-bit support
    wineWowPackages.stable
    
    # Wine staging with both 32-bit and 64-bit support
    wineWowPackages.staging
    
    # Wine utilities and tools
    winetricks
    protontricks
    bottles
    
    # DirectX translation layers
    dxvk
    vkd3d
    
    # Additional libraries for better compatibility
    mono
    samba
  ];

  # Enable 32-bit support for Wine
  hardware.graphics.enable32Bit = true;
  
  # Enable OpenGL for both 32-bit and 64-bit applications
  hardware.graphics.enable = true;
}
