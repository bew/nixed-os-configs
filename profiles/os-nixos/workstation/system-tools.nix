{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted # disk partitioning tool
    kdePackages.filelight # disk usage stats
    ntfs3g # ntfs driver tools

    lshw # Show hardware info
    pciutils # Show pci hardware info (e.g. lspci)
    usbutils # Tools for working with USB devices (e.g. lsusb)
  ];
}
