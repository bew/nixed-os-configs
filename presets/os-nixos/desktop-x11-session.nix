{ config, pkgs, lib, ... }:

{
  # note: everything here basically breaks on wayland
  # (or 'kinda' only works on XWayland windows)
  config = lib.mkIf (!config.me.trying-out-wayland) {
    services.redshift.enable = true;
    services.redshift.package = pkgs.redshift.override { withGeolocation = false; };
    location = {
      # Paris
      # ref: https://www.latlong.net/place/paris-france-1666.html
      latitude = 48.864716;
      longitude = 2.349014;
    };

    environment.systemPackages = with pkgs; [
      xclip
      xdotool
      xev # X EVent viewer

      # recording..
      simplescreenrecorder # simple (to use) yet powerful Screen Recorder
      screenkey # hover key presses
      peek # record GIF/MP4
    ];
  };
}
