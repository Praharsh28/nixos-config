{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix

    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/audio.nix
    ./modules/gpu.nix
    ./modules/gaming.nix
    ./modules/containers.nix
    ./modules/users.nix
    ./modules/services.nix
    ./modules/networking.nix
    ./modules/system.nix
    ./modules/udev.nix
    ./modules/jetbrains.nix
    ./modules/command-not-found.nix
    ./modules/dev-tools.nix
    ./modules/media-tools.nix
    ./modules/system-utils.nix
    ./modules/wine.nix
    ./modules/iso-tools.nix
    ./modules/torrent.nix
         ./modules/sandbox-gaming.nix
   ];

  nixpkgs.config.allowUnfree = true;
}
