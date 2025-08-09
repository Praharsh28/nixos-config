{ config, pkgs, ... }:
{
  system.stateVersion = "25.05";
  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_MONETARY = "en_IN";
    LC_PAPER = "en_IN";
    LC_NAME = "en_IN";
    LC_ADDRESS = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_IDENTIFICATION = "en_IN";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    max-jobs = "auto";
    cores = 0;
    keep-outputs = true;
    keep-derivations = true;

    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQF65Z8Q8h3M="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "03:45" ];
  };

  # Enable Flatpak support
  services.flatpak.enable = true;

  # Automatically ensure Flathub repository is added and Logseq is installed
  system.activationScripts.flatpak-logseq = ''
    # Check internet connectivity first
    if ping -c 1 flathub.org &>/dev/null; then
      echo "Network connectivity to Flathub confirmed, proceeding with Flatpak setup..."
      
      # Add Flathub repository if it doesn't exist
      $DRY_RUN_CMD ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      
      # Install Logseq if not already installed (runs non-interactively with -y)
      if ! $DRY_RUN_CMD ${pkgs.flatpak}/bin/flatpak list --app | grep -q com.logseq.Logseq; then
        $DRY_RUN_CMD ${pkgs.flatpak}/bin/flatpak install -y flathub com.logseq.Logseq
      fi
    else
      echo "No network connectivity to Flathub detected, skipping Flatpak setup..."
      # Return success even without connectivity to prevent activation failure
      true
    fi
  '';

  # Automatic system updates using flakes (safe: test then switch)
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = "path:/etc/nixos#nixos";
    allowReboot = false;
    operation = "switch";
  };

  zramSwap = {
    enable = true;
    memoryPercent = 10;
    algorithm = "zstd";
    priority = 100;
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      dejavu_fonts liberation_ttf noto-fonts noto-fonts-cjk-sans
      noto-fonts-emoji fira-code fira-code-symbols
    ];
  };

  environment.systemPackages = with pkgs; [
    wget curl git gnupg unzip zip p7zip unrar rar xz gzip bzip2 zstd vim nano tree file
    htop btop neofetch fastfetch pciutils usbutils lshw
    openssh nmap mtr nettools inetutils
    gcc gnumake cmake pkg-config clang python3 nodejs
    git-lfs helix neovim vscode
    firefox google-chrome
    gimp inkscape krita
    discord signal-desktop
    kdePackages.kate kdePackages.dolphin kdePackages.spectacle
    kdePackages.partitionmanager kdePackages.ark kdePackages.plasma-systemmonitor kdePackages.plasma-pa
    kdePackages.konsole kdePackages.okular kdePackages.gwenview
    kdePackages.kcalc kdePackages.kcharselect kdePackages.kcolorchooser
    kdePackages.kruler kdePackages.ksystemlog kdePackages.kdeconnect-kde
    kdePackages.krfb kdePackages.krdc kdePackages.kdevelop kdePackages.kompare
    kdePackages.dragon kdePackages.elisa kdePackages.k3b kdePackages.filelight
    kdePackages.sweeper kdePackages.kinfocenter
    wl-clipboard wtype wlr-randr libnotify playerctl
    vlc mpv obs-studio pavucontrol gparted flameshot
    steam steam-run gamemode mangohud lutris
    powertop tlp
    nix-index nix-tree nixfmt-rfc-style
    mesa-demos syncthing nvidia-container-toolkit
    podman-compose appimage-run
    iotop nvtopPackages.full cpupower-gui
    dejavu_fonts liberation_ttf noto-fonts-cjk-sans noto-fonts-emoji
    fira-code fira-code-symbols
    steamcmd
    retroarch dolphin-emu rpcs3
    mumble teamspeak_client
    podman-compose buildah skopeo dive ctop lazydocker
    distrobox toolbox
    windsurf
    flatpak
  ];

  # Robustness and hardening
  systemd.oomd.enable = true;

  services.journald = {
    extraConfig = ''
      Storage=persistent
      SystemMaxUse=1G
      RuntimeMaxUse=256M
      MaxRetentionSec=1month
      Compress=yes
      Seal=yes
    '';
  };

  boot.tmp.cleanOnBoot = true;

  services.fwupd.enable = true;

  programs.mtr.enable = true;

  security.protectKernelImage = true;
  security.sudo.execWheelOnly = true;
}
