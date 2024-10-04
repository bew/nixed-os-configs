{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "frametop";

  boot.kernelPackages = pkgs.linuxPackages_6_6; # Linux 6.6 is LTS (@2023-12)

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "10G";

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Bluetooth
  #   In GUI, KDE has nice bluedevil UI in panel widget & settings
  #   In cli, `bluetoothctl` can inspect & do BT-related actions
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # power default controller on boot / resume from suspend

  # FIXME: where to move this info? REMOVE?
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
}
