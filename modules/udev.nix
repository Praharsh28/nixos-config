{ config, pkgs, ... }:
{
  services.udev.extraRules = ''
    # NVIDIA GPU power management
    SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", ATTR{power/control}="auto"
    SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", ATTR{power/control}="auto"

    # Intel GPU power management
    SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{class}=="0x030000", ATTR{power/control}="auto"

    # Gaming controller support
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0664", GROUP="users"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="054c", MODE="0664", GROUP="users"

    # Disable autosuspend on gaming peripherals
    SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTR{power/autosuspend}="-1"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1532", ATTR{power/autosuspend}="-1"

    # NVIDIA gaming performance override
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", ATTR{power/control}="on"
  '';
}
