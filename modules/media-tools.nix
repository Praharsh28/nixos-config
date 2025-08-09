{ config, pkgs, ... }:

{
  # Media tools and codecs
  environment.systemPackages = with pkgs; [
    # Audio tools
    audacity
    ffmpeg
    
    # Image editing and viewing
    darktable
    
    # Screenshot and screen recording
    peek
    
    # PDF tools
    poppler_utils
    pdftk
    
    # Media codecs and libraries
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    libdvdcss
    libopus
    libvorbis
    libvpx
    x264
    x265
    
    # Hardware acceleration packages
    libva
    libva-utils
    vaapiVdpau
    libvdpau-va-gl
  ];
  
  # Enable hardware acceleration for video
  hardware.graphics.enable = true;
}
