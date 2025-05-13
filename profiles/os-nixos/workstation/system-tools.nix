{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted
    ntfs3g
    kdePackages.filelight
  ];
}
