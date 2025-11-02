# NOTE: This package was useful to test out a program on Wayland while staying on X11 with a basic
# desktop layer (just a WM) but sensible keybindings so I'm not _completely_ lost.

{
  lib,
  writeText,
  buildEnv,
  makeWrapper,

  # main pkg
  sway,

  # config dependencies
  rofi-wayland,
  wezterm,
}:

let

  config = writeText "sway-mini-config" /* swaycfg */ ''
    input * xkb_layout fr

    # Mod1 <=> Alt key (to be different from my host' desktop)
    set $alt Mod1

    # Set modifier used to move/resize a window
    floating_modifier $alt normal

    # Quit Sway
    bindsym Ctrl+Shift+q \
      exit
    bindsym Ctrl+$alt+q \
      exit

    # Open a program
    bindsym $alt+x \
      exec ${lib.getExe rofi-wayland} -show drun

    # Open terminal
    bindsym $alt+Space \
      exec ${lib.getExe wezterm}

    bindsym Ctrl+$alt+f \
      floating toggle
  '';

in buildEnv {
  name = "sway-mini-preconfig";
  meta.mainProgram = "sway-mini-preconfig";
  paths = [ sway ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = /* sh */ ''
    rm $out/bin # the original bin symlink (which I can't write to)
    mkdir $out/bin
    ln -s ${sway}/bin/* $out/bin # Add symlinks to sway bins (sway, swaymsg, ..)
    # Add mine with a minimal config:
    makeWrapper ${lib.getExe sway} $out/bin/sway-mini-preconfig \
      --add-flags "--config ${config}"
  '';
}
