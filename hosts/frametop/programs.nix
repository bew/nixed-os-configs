{ pkgs, pkgsets, lib, ... }:

let inherit (pkgsets) stable bleedingedge mypkgs; in

{
  imports = [
    ./protonvpn.nix
    ../../presets/os-nixos/firefox

    ../../presets/os-nixos/gaming.nix # 󰊴 !
    ../../presets/os-nixos/minecraft.nix
    ../../presets/os-nixos/warez.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # ⚠ non-free!
  services.teamviewer.enable = true;

  environment.systemPackages = [
    (bleedingedge.wezterm.overrideAttrs {
      patches = [
        (pkgs.fetchpatch {
          # Wayland scroll behavior
          # PR: https://github.com/wezterm/wezterm/pull/6533
          url = "https://github.com/wezterm/wezterm/pull/6533/commits/55b7c9feea118f63734dbcdeb518cfadea652094.patch";
          hash = "sha256-S8GZfcgSek03K3RbKDcsA34ucHzxc8nxB6NE5/0CVnM=";
        })
      ];
    })
    stable.alacritty # (in case wezterm broken)

    # -- Media / Other
    # @mpv daemon-start <channel> / add <channel> / …
    (mypkgs.mpv-channel-helpers.override { mpv = "from-PATH"; })

    stable.prusa-slicer

    # FIXME: need bleedingedge!
    # beeper # ⚠ non-free!
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
