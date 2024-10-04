{ pkgs, ... }:
{
  imports = [
    ./nix-settings.nix
    ./localization.nix

    ./base-tools.nix
    ./system-tools.nix
  ];

  _module.args.myPkgs = import ../../../mypkgs/default.nix { inherit pkgs; };

  console = {
    font = "Lat2-Terminus16";
  };

  # This will regularly tell the SSD which blocks are deleted on the filesystem side,
  # so these blocks can be used for other things by the SSD controller.
  # => Helps SSD performance & lifespan!
  # See: https://en.wikipedia.org/wiki/Trim_(computing)
  services.fstrim.enable = true; # note: Runs weekly
}
