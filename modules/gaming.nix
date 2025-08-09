{ config, pkgs, ... }:
{
  # Additional gaming packages
  environment.systemPackages = with pkgs; [
    # Vulkan tools for diagnostics and testing
    vulkan-tools
    
    # Enhanced Wine with better gaming support
    wineWowPackages.staging
    
    # DirectX translation layers
    dxvk
    vkd3d
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor xorg.libXi xorg.libXinerama xorg.libXScrnSaver
        libpng libpulseaudio libvorbis stdenv.cc.cc.lib libkrb5 keyutils
        mangohud gamemode winetricks
        vulkan-loader vulkan-validation-layers mesa openal
      ];
    };
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        ioprio = 1;
        inhibit_screensaver = 1;
        desiredgov = "performance";
        igpu_desiredgov = "performance";
        softrealtime = "auto";
        reaper_freq = 5;
      };
      filter = {
        whitelist = 1;
        blacklist = 0;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Gaming optimizations active' --icon=input-gaming";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Gaming optimizations disabled' --icon=application-exit";
      };
    };
  };
}
