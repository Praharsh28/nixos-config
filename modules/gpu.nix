{ config, pkgs, lib, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      allowExternalGpu = false;
      reverseSync.enable = false;
    };
    forceFullCompositionPipeline = false;
    nvidiaPersistenced = true;
  };

  systemd.services.nvidia-shader-cache = {
    description = "Create NVIDIA shader cache directory";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = [
        "${pkgs.coreutils}/bin/mkdir -p /tmp/nvidia-shader-cache"
        "${pkgs.coreutils}/bin/chmod 1777 /tmp/nvidia-shader-cache"
      ];
    };
  };
}
