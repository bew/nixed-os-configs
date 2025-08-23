{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.me.trying-out-wayland {
    environment.systemPackages = with pkgs; [
      xorg.xeyes # note: Useful even on Wayland to 'detect' XWayland-based windows

      wev # Wayland EVent viewer
    ];
  };
}
