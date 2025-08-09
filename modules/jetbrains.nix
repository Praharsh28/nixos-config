{ config, pkgs, lib, ... }:

{
  # Enable JetBrains Toolbox
  environment.systemPackages = with pkgs; [
    jetbrains-toolbox
  ];

  # Enable nix-ld to make JetBrains IDEs work properly
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Basic system libraries
      stdenv.cc.cc
      zlib
      xz
      openssl
      curl
      expat
      
      # Graphics and UI libraries
      libGL
      libGLU
      glew110
      mesa
      vulkan-loader
      
      # X11 libraries
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXtst
      xorg.libXi
      xorg.libXrandr
      xorg.libXcursor
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXfixes
      xorg.libXinerama
      xorg.libxcb
      
      # Wayland support
      wayland
      
      # GTK and related libraries
      gtk2
      gtk3
      glib
      pango
      cairo
      gdk-pixbuf
      atk
      at-spi2-atk
      at-spi2-core
      
      # Audio libraries
      alsa-lib
      libpulseaudio
      
      # Font libraries
      fontconfig
      freetype
      
      # Other common dependencies
      dbus
      cups
      libusb1
      libuuid
      libsecret
      
      # Multimedia libraries
      libpng
      libjpeg
      libtiff
    ];
  };
}
