{ pkgs, myPkgs, ... }:

{
  imports = [
    ../common/optional/firefox
  ];

  nixpkgs.config.allowUnfree = true;

  # ⚠ non-free!
  services.teamviewer.enable = true;

  environment.systemPackages = with pkgs; [
    # TODO: add when it's recent enough!
    #   (I don't have bleedingedge repo available here atm)
    # wezterm # (❤ )

    # -- Media / Other
    myPkgs.mpv-channel-helpers # @mpv daemon-start <channel> / add <channel> / …
    kdenlive

    prusa-slicer

    beeper # ⚠ non-free!
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
