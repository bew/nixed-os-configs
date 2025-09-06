{ pkgs, myPkgs, lib, ... }:

{
  imports = [
    ./protonvpn.nix
    ../../presets/os-nixos/firefox

    ../../presets/os-nixos/gaming.nix # 󰊴 !
    ../../presets/os-nixos/warez.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # ⚠ non-free!
  services.teamviewer.enable = true;

  environment.systemPackages = with pkgs; [
    # TODO: add when it's recent enough!
    #   (I don't have bleedingedge repo available here atm)
    # wezterm # (❤ )
    alacritty # (in case wezterm broken)

    # -- Media / Other
    # @mpv daemon-start <channel> / add <channel> / …
    (myPkgs.mpv-channel-helpers.override { mpv = "from-PATH"; })

    prusa-slicer

    beeper # ⚠ non-free!

    # Add a minimal Sway config, to easily test Wayland stuff from X
    (
      let
        config = pkgs.writeText "sway-mini-config" /* swaycfg */ ''
          input * xkb_layout fr

          # Mod1 <=> Alt key
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
            exec ${lib.getExe pkgs.rofi-wayland} -show drun

          # Open terminal
          bindsym $alt+Space \
            exec ${lib.getExe pkgs.wezterm}

          bindsym Ctrl+$alt+f \
            floating toggle
        '';
        sway-pkg = pkgs.sway;
      in pkgs.buildEnv {
        name = "sway-mini-preconfig";
        meta.mainProgram = "";
        paths = [ sway-pkg ];
        nativeBuildInputs = [ makeWrapper ];
        postBuild = /* sh */ ''
          rm $out/bin # the original bin symlink (which I can't write to)
          mkdir $out/bin
          ln -s ${sway-pkg}/bin/* $out/bin # Add symlinks to sway bins (sway, swaymsg, ..)
          makeWrapper ${lib.getExe sway-pkg} $out/bin/sway-mini-preconfig \
            --add-flags "--config ${config}"
        '';
      }
    )
  ];

  services.flatpak.enable = true;
  # FIXME: Add a way to declaratively track & configure flatpak apps?
  # Way to declare which remote repo of flatpaks to track (flathub / ..)
  # Ways to declaratively describe which flatpaks I want to track? (system level / user level)
  #   (and make wrappers or `@flat wrapper` to easily call them?)
  #   Way to check / test an app work on upgrade?
  #   Allow them to update themself using some flatpak cmds? or have a version/hash of a specific version I want?
  # Could also setup overrides globally / per app:
  #   https://docs.flatpak.org/en/latest/flatpak-command-reference.html#flatpak-override
  #
  # This might be useful to better share system fonts & icons:
  #   https://github.com/NixOS/nixpkgs/issues/119433#issuecomment-1326957279
  #   although it might be simpler to use `mount --bind ...` call instead of `bindfs`
}
