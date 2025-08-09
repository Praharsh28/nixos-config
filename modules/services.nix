{ config, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    user = "enigma";
    dataDir = "/mnt/nixstorage/Software/Portable_Apps/logseq/logseq data/";
    configDir = "/home/enigma/.config/syncthing";
  };

  services.fstrim.enable = true;
  services.thermald.enable = true;
  services.hardware.bolt.enable = true;

  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
    };
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };

  services.power-profiles-daemon.enable = false;

  # Hardened OpenSSH and time sync
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
      AllowTcpForwarding = "no";
      ClientAliveInterval = 300;
      ClientAliveCountMax = 2;
      # Modern ciphers/MACs/KexAlgorithms are defaults in recent releases, ensure no weak ones are used
    };
    openFirewall = false;
  };

  time.timeZone = lib.mkDefault "Asia/Kolkata";
  services.timesyncd.enable = true;
}
