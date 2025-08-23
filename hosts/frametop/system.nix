{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_12; # (note: Linux 6.12 is LTS @2024-11)

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "10G";

  # Bluetooth
  #   In GUI, KDE has nice bluedevil UI in panel widget & settings
  #   In cli, `bluetoothctl` can inspect & do BT-related actions
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # power default controller on boot / resume from suspend

  # Enable LVFS for firmware updates (when needed)
  # ( LVFS: Linux Vendor Firmware Service, see: https://fwupd.org/ )
  # services.fwupd.enable = true;
}
