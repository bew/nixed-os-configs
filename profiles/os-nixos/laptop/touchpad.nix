{ lib, config, ... }:

{
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad = {
    # FIXME: Is there a way to configure the timeout until the touchpad is re-enabled again?
    #   Or a way to disable taps for a bit longer? (drag is not an issue)
    #   -> Or even disable touchpad tap (click) when a non-modifier key is pressed until I drag the mouse around.
    #      => TODO: open an dedicated issue for this?
    # On the Framework, the touchpad is BIG, and not exactly centered w.r.t. `f` & `j` keys,
    # and when I type, the internal edge of my right palm is actually over the touchpad.
    # => It happens too often that I tap the touchpad with it by mistake,
    #    moving the cursor to unwanted / surprising locations..
    # Disabling mouse action in vim's insert mode is not enough, it also happens on normal mode and
    # in other GUI programs, and have been destructive more than once!
    #
    # Upstream feature request issues:
    # - https://gitlab.freedesktop.org/libinput/libinput/-/issues/379
    # - https://gitlab.freedesktop.org/libinput/libinput/-/issues/619
    disableWhileTyping = true;

    tappingDragLock = false; # It's just annoying to have it and be surprised when doing fast movements..
    additionalOptions = lib.mkIf (!config.me.trying-out-wayland) ''
      # Tapping with 1/2/3 fingers give left/right/middle buttons respectively
      # Ref: https://wiki.archlinux.org/title/libinput#Tapping_button_re-mapping
      Option "TappingButtonMap" "lrm"
    '';
  };
}
