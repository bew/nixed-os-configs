{ config, lib, pkgs, ... }:

{
  imports = [
    ./input-remaps.nix
    ./zsa-keyboards-edit-support.nix
    ./monitoring.nix
    ./system-tools.nix

    ../../../presets/os-nixos/audio.nix
    ../../../presets/os-nixos/media-view.nix
    ../../../presets/os-nixos/media-edit.nix

    # Vendored fix for Espanso on wayland
    # Source: https://github.com/NixOS/nixpkgs/pull/328890
    ./espanso-cap-override-fix-for-wayland
  ];

  services.espanso.enable = true;
  services.espanso.package = lib.mkIf config.me.trying-out-wayland pkgs.espanso-wayland;
  # On wayland it doesn't work well as the package is missing a capability:
  # https://github.com/NixOS/nixpkgs/issues/249364
  # Hacky PR to fix: https://github.com/NixOS/nixpkgs/pull/328890
  # Vendored in my repo in the meantime.
  programs.espanso.capdacoverride.enable = lib.mkIf config.me.trying-out-wayland true;

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
