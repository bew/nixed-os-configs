{ pkgs, ... }:

{
  imports = [
    ./input-remaps.nix
    ./zsa-keyboards-edit-support.nix
    ./monitoring.nix
    ./system-tools.nix

    ../../../modules/os-nixos/audio.nix
    ../../../modules/os-nixos/media-view.nix
  ];

  services.espanso.enable = true;

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

    libreoffice
  ];
}
