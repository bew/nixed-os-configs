{ pkgs, ... }:

{
  imports = [
    # Disable the KDE file indexer `baloo`, when I add/delete/change a lot of small files
    # (e.g: when cloning / compressing / deleting the nixpkgs repo) baloo seems to update
    # its cache like crazy by writing 100M/s on the disk for many minutes (10-15?)...
    # And I actually never use file search that needs pre-indexing, so bye bye o/
    ./disable-kde-file-indexer.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  environment.systemPackages = with pkgs; [
    dunst # notification handler (I prefer those to KDE native ones 👀 (@2023~))
  ];
}
