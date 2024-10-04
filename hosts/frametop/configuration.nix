{ pkgs, myPkgs, ... }:

{
  imports = [
    ../common/core # Common to ALL hosts

    ../common/optional/laptop
    ../common/optional/workstation

    ../common/optional/flatpak.nix
    ../common/optional/desktop-kde-plasma

    ../common/optional/firefox.nix
    ../common/optional/firefox-extensions.nix
  ];

  # IDEA: 'options' that act as hardware reference, to be able to access the hardware info in a pure way at eval time,
  # to allow writing this option relative to hardware info:
  # nix.settings.cores = config.hardware-specs.cpuCount / 2;
  nix.settings.cores = 8;

  users.users.bew = {
    isNormalUser = true;
    # note: nice reference of system groups:
    # https://wiki.debian.org/SystemGroups#Groups_without_an_associated_user
    extraGroups = [
      "wheel" # Enable *sudo* for the user.
      "plugdev" # Allow to mount/unmount removable devices (necessary for some ZSA features)
    ];
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    # TODO: add when it's recent enough!
    #   (I don't have bleedingedge repo available here atm)
    # wezterm # (❤ )

    # -- Media / Other
    myPkgs.mpv-channel-helpers # @mpv daemon-start <channel> / add <channel> / …
    kdenlive

    prusa-slicer
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
