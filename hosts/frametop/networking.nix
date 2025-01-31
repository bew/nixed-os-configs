{ pkgs, ... }:

{
  networking.hostName = "frametop";

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # Use `iwd` backend, which is newer/better/smarter than `wpa_supplicant`.
  # ref: https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/
  # ref: "The New Wi-Fi Experience for Linux @2018"
  #   https://www.youtube.com/watch?v=QIqT2obSPDk (~45min)
  networking.networkmanager.wifi.backend = "iwd";
}
