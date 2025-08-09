# ❄️ NixOS 25.05 Modular Flake Configuration (AORUS Laptop Setup)

This repository contains a modular, optimized NixOS 25.05 configuration using flakes, tailored for a high-performance Intel + NVIDIA hybrid laptop (GIGABYTE AORUS 16X).

---

## 📁 Directory Structure

```
/etc/nixos/
├── flake.nix                  # Flake definition and inputs
├── configuration.nix         # Entry point imports all modules
├── home.nix                  # Home Manager config for user 'enigma'
├── hardware-configuration.nix # Auto-generated during installation
└── modules/                  # Modular system configuration
    ├── audio.nix
    ├── boot.nix
    ├── containers.nix
    ├── desktop.nix
    ├── gaming.nix
    ├── gpu.nix
    ├── networking.nix
    ├── services.nix
    ├── system.nix
    ├── users.nix
    └── udev.nix
```

---

## 🧩 Modules Overview

### 🔧 `boot.nix`
- Optimized initrd compression (`zstd`), reduced timeout
- Intel/NVIDIA hybrid tuning via kernel parameters
- Plymouth theme + early loading modules

### 🎧 `audio.nix`
- Low-latency PipeWire with JACK & PulseAudio support
- Clock quantum tuning for real-time audio

### 🎮 `gaming.nix`
- Steam with Proton-GE, mangohud, gamemode
- GameMode notifications & scheduler tuning

### 📦 `containers.nix`
- Docker, Podman, OCI backend
- Overlay storage tuning
- Weekly auto-prune service

### 🖥️ `desktop.nix`
- KDE Plasma 6 on Wayland (SDDM, Qt6 friendly)
- X11 fallback + xrandr setup
- Portal integration for Flatpak

### 🎨 `gpu.nix`
- PRIME offloading with NVIDIA + Intel
- Shader cache directory service
- Power/performance tuning

### 🌐 `networking.nix`
- NetworkManager
- Avahi (mDNS)
- Bluetooth with experimental codecs

### 🔌 `services.nix`
- Syncthing with custom data dir
- thermald, bolt, auto-cpufreq
- Printing, locate, fstrim

### 👤 `users.nix`
- User `enigma` with dev/media groups
- Zsh as default shell
- GnuPG agent + SSH integration

### 🛠️ `system.nix`
- Locale, time zone, nix settings
- ZRAM, systemd tweaks
- Font and system package declarations

### 🎮 `udev.nix`
- Power management rules for NVIDIA/Intel GPUs
- USB rules for game controllers & gaming peripherals

---

## 🧪 Useful Commands

```bash
# Update flake inputs
nix flake update

# Rebuild system
sudo nixos-rebuild switch --flake .#enigma

# Test or boot variants
sudo nixos-rebuild test --flake .#enigma
sudo nixos-rebuild boot --flake .#enigma
```

---

## 🧭 Notes
- Built for GIGABYTE AORUS 16X (14th Gen Intel + NVIDIA)
- Single-machine setup, flake-enabled
- Ready for gaming, development, content creation, containers
- Easy to scale into `hosts/` or `roles/` structure if needed

---

## 📜 License
Personal configuration — use ideas freely, but verify hardware-specific tweaks.

