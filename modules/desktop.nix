{ config, pkgs, lib, ... }:
{
  services.xserver = {
    enable = true;
    xkb.layout = "gb";
    displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource modesetting NVIDIA-0
      ${pkgs.xorg.xrandr}/bin/xrandr --auto
    '';
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge ~/.Xresources 2>/dev/null || true
      ${pkgs.xorg.xsetroot}/bin/xsetroot -cursor_name left_ptr 2>/dev/null || true
    '';
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings = {
      General = {
        DisplayServer = "wayland";
        Numlock = "on";
        EnableHiDPI = true;
        MinimumVT = 7;
      };
      Theme = {
        Current = "breeze";
        CursorTheme = "breeze_cursors";
        CursorSize = 24;
      };
      Users = {
        MaximumUid = 60000;
        MinimumUid = 1000;
        HideUsers = "nobody,systemd-network,systemd-resolve";
        RememberLastUser = true;
        RememberLastSession = true;
      };
      Wayland.SessionDir = "/run/current-system/sw/share/wayland-sessions";
      X11 = {
        SessionDir = "/run/current-system/sw/share/xsessions";
        ServerArguments = "-nolisten tcp -dpi 96";
      };
    };
    theme = "breeze";
  };

  services.displayManager.environment = {
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_WAYLAND_FORCE_DPI = "physical";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR = "1";
    QT_QUICK_BACKEND = "rhi";
    QT_QPA_PLATFORMTHEME = "kde";
  };

  systemd.services.display-manager = {
    wants = [ "systemd-user-sessions.service" ];
    after = [
      "systemd-user-sessions.service"
      "plymouth-quit-wait.service"
      "getty@tty1.service"
    ];
    serviceConfig = {
      Restart = lib.mkForce "always";
      RestartSec = lib.mkForce "1s";
      KillMode = lib.mkDefault "mixed";
      KillSignal = lib.mkDefault "SIGTERM";
      TimeoutStopSec = lib.mkDefault "30s";
      Nice = lib.mkDefault "-1";
      IOSchedulingClass = lib.mkDefault 1;
      IOSchedulingPriority = lib.mkDefault 4;
    };
  };

  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
  };

  environment.sessionVariables = {
    NVIDIA_OFFLOAD_CMD = "nvidia-offload";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json:/run/opengl-driver/share/vulkan/icd.d/intel_icd.json";
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_PATH = "/tmp/nvidia-shader-cache";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    KWIN_COMPOSE = "O2";
    KWIN_TRIPLE_BUFFER = "1";
    QT_WAYLAND_DECORATION = "adwaita";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_ENABLE_HIGHDPI_SCALING = "1";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    config = {
      common.default = [ "kde" ];
      common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      kde = {
        default = [ "kde" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
        "org.freedesktop.impl.portal.AppChooser" = [ "kde" ];
        "org.freedesktop.impl.portal.Print" = [ "kde" ];
        "org.freedesktop.impl.portal.Notification" = [ "kde" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "kde" ];
      };
    };
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
  };

  services.accounts-daemon.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;
  services.colord.enable = true;
}
