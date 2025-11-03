{ pkgs, config, lib, ... }:

let
  cfg = config.pkgsets;
  ty = lib.types;

  pkgsetForSys = system: maybePkgSet: (
    if maybePkgSet ? legacyPackages then
      maybePkgSet.legacyPackages.${system}
    else if maybePkgSet ? packages then
      maybePkgSet.packages.${system}
    else
      maybePkgSet
  );

  system = pkgs.stdenv.hostPlatform.system;
in {
  # FIXME: Find a way to set configs like allowUnfreePredicate globally for all/some pkgsets 🤔
  #   -> needed for beeper, terraform, ...
  options = {
    pkgsets.define = lib.mkOption {
      description = ''
        The various pkgssets to make available in `_module.args.pkgsets` for all modules.
        Each pkgsets must be unique (cannot merge), and can be given directly without having to access `legacyPackages.''${system}`
      '';
      defaultText = ''
        {
          somepkgs = inputs.custom-nixpkgs;
        }
      '';
      type = ty.uniq (ty.attrsOf (ty.either ty.pkgs ty.attrs));
    };
  };

  config = {
    _module.args.pkgsets = lib.mapAttrs (name: value: pkgsetForSys system value) cfg.define;
  };
}
