{ config, pkgs, lib, ... }:
{
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
    consoleMode = "auto";
    editor = false;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;

  boot.initrd = {
    compressor = "zstd";
    compressorArgs = [ "-19" "-T0" ];
    verbose = false;
    network.enable = false;
    systemd.enable = true;
    kernelModules = [ "nvme" "i915" ];
    services = {}; # placeholder
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    "intel_idle.max_cstate=3"
    "processor.max_cstate=3"
    "intel_pstate=active"
    "nvme_core.default_ps_max_latency_us=0"
    "mitigations=auto"
    "quiet"
    "splash"
    "resume_offset=0"
    "loglevel=3"
    "threadirqs"
    "split_lock_detect=off"
    "clocksource=tsc"
  ];

  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelModules = [ "kvm-intel" "msr" "coretemp" ];

  boot.initrd.supportedFilesystems = [ "ext4" "btrfs" "vfat" "ntfs" "exfat" "f2fs" ];
  boot.supportedFilesystems = [ "ntfs" "exfat" "f2fs" ];

  boot.plymouth = {
    enable = true;
    theme = "breeze";
    font = "${pkgs.dejavu_fonts.out}/share/fonts/truetype/DejaVuSans.ttf";
  };
}
