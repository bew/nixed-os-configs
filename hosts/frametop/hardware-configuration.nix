{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # FIXME: is this necessary? or can be removed?
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm_amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/255a13b8-4f26-4399-bd39-42d66d32c4c8";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/478f9df6-9528-4d0a-83e9-165065564ee4";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8984-02DF";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/c0ca0670-d078-4bcc-868c-96fca452dbc5"; }
  ];

  # FIXME: is this necessary? or can be removed?
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
