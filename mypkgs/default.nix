{ pkgs }:

let
  inherit (pkgs) callPackage;
in {
  mpvScripts = {
    copyTime = (callPackage ./mpv-scripts/mpv-copyTime.nix {});
    modernx = (callPackage ./mpv-scripts/mpv-modernx.nix {});
    thumbfast = (callPackage ./mpv-scripts/mpv-thumbfast.nix {});
    undoredo = (callPackage ./mpv-scripts/mpv-undoredo.nix {});
    uosc = (callPackage ./mpv-scripts/mpv-uosc.nix {});
  };

  mpvConfigurable = callPackage ./mpv-configurable.nix {};
  mpv-channel-helpers = callPackage ./mpv-channel-helpers {};

  zsa-keymapp = callPackage ./zsa-keymapp {};

  sway-mini-config = callPackage ./sway-mini-config {};
}
