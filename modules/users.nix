{ config, pkgs, ... }:
{
  users.users.enigma = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "podman" "docker" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.ssh.startAgent = false;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Sudo policy: wheel can sudo, require tty
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
    extraConfig = ''
      Defaults requiretty
    '';
  };
}
