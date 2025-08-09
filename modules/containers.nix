{ config, pkgs, lib, ... }:
{
  virtualisation.containers = {
    enable = true;
    storage.settings = {
      storage = {
        driver = "overlay";
        runroot = "/run/containers/storage";
        graphroot = "/var/lib/containers/storage";
        options.overlay = {
          mount_program = "${pkgs.fuse-overlayfs}/bin/fuse-overlayfs";
          mountopt = "nodev,fsync=0";
        };
      };
    };
    registries.search = [
      "docker.io"
      "registry.fedoraproject.org"
      "quay.io"
      "registry.access.redhat.com"
    ];
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
    dockerSocket.enable = false;
    defaultNetwork.settings = {
      dns_enabled = true;
      ipv6_enabled = true;
    };
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" "--filter" "until=168h" ];
    };
    extraPackages = with pkgs; [
      podman-compose buildah skopeo
      fuse-overlayfs slirp4netns
    ];
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--volumes" "--filter" "until=168h" ];
    };
    daemon.settings = {
      storage-driver = "overlay2";
      max-concurrent-downloads = 6;
      max-concurrent-uploads = 6;
      log-driver = "journald";
      log-opts = {
        max-size = "100m";
        max-file = "3";
      };
      default-ulimits.nofile = {
        hard = 64000;
        soft = 64000;
      };
      live-restore = true;
      userland-proxy = false;
    };
    package = pkgs.docker.override {
      buildxSupport = true;
    };
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {};
  };

  networking.firewall.interfaces."podman+" = {
    allowedUDPPorts = [ 53 ];
    allowedTCPPorts = [ 53 ];
  };

  systemd.services.container-cleanup = {
    description = "Clean up unused container resources";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = [
        "${pkgs.podman}/bin/podman system prune -af --filter until=168h"
        "${pkgs.docker}/bin/docker system prune -af --filter until=168h"
      ];
    };
    startAt = "weekly";
  };
}
