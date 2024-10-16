{ pkgs, ... }:

{
  imports = [
    ./input-remaps.nix
    ./zsa-keyboards-edit-support.nix
    ./monitoring.nix
    ./system-tools.nix

    ./../audio.nix
    ./../media-view.nix
  ];

  # Not specific to KDE Plasma desktop ;)
  # ref: <https://kdeconnect.kde.org/>
  programs.kdeconnect.enable = true;

  # `dconf` is necessary by gtk-based programs to save their settings, otherwise you get the
  # following warning:
  # `failed to commit changes to dconf: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name ca.desrt.dconf was not provided by any .service files`
  programs.dconf.enable = true;

  networking.firewall.allowedTCPPorts = [
    1234 # usually used for SHORT-TERM tests, should be open if used!
  ];

  environment.systemPackages = with pkgs; [
    appimage-run # to easily run downloaded appimage files
    ark # a nice archive gui (has integration with KDE desktop)

    libreoffice

    # Install with the system to ensure the same qt version is used.
    # See <20230328T1209#incompatible-qt>
    transmission-qt
  ];
}
