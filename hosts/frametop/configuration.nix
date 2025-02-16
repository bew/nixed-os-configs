{ pkgs, ... }:

{
  imports = [
    ../nixos-profiles/core # Common to ALL hosts

    ../nixos-profiles/laptop
    ../nixos-profiles/workstation

    ../../modules/os-nixos/desktop-kde-plasma
    ../../modules/os-nixos/x11-session.nix

    ./programs.nix
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
      "nix-trusted" # Allow control of the Nix daemon (this is a custom group).
      "plugdev" # Allow to mount/unmount removable devices (necessary for some ZSA features)
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
