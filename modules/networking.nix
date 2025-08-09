{ config, pkgs, ... }:
{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1" "9.9.9.9" ];
  };

  networking.firewall = {
    enable = true;
    logRefusedConnections = false;
    allowedTCPPorts = [ 80 443 8384 22000 ];
    allowedUDPPorts = [ 5353 21027 ];
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;
}
