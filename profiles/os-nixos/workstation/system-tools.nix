{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted
    ntfs3g
    kdePackages.filelight

    lshw # Show hardware info
    pciutils # Show pci hardware info
  ];
}
