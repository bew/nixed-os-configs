{ config, pkgs, ... }:

{
  imports = [
    # Disable the KDE file indexer `baloo`, when I add/delete/change a lot of small files
    # (e.g: when cloning / compressing / deleting the nixpkgs repo) baloo seems to update
    # its cache like crazy by writing 100M/s on the disk for many minutes (10-15?)...
    # And I actually never use file search that needs pre-indexing, so bye bye o/
    ./disable-kde-file-indexer.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = !config.me.trying-out-wayland;

  services.displayManager.sddm.enable = true;

  # Enable the Plasma 6 Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  # Plasma 6 runs on Wayland by default. But I want X11.
  # REF: https://wiki.nixos.org/wiki/KDE#Default_Wayland/X11_session
  services.displayManager.defaultSession = (
    if config.me.trying-out-wayland
    then "plasma" # Wayland
    else "plasmax11" # X11
  );

  environment.systemPackages = with pkgs; [
    kdePackages.ark # a nice archive gui integrated into Dolphin
  ];
}
