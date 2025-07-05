let
  inputs = import ./inputs-npins;
  loadFlake = flakeInput: (import inputs.flake-compat { src = flakeInput; }).outputs;

  # expose inputs
  system-nixpkgs = loadFlake inputs.system-nixpkgs;
  nixos-hardware = loadFlake inputs.nixos-hardware;
  # note: netdata v2+ is now cloud-only, no local web ui available anymore
  #   so we force the use of the last netdata v1 we have in 24.11
  netdata-nixpkgs = loadFlake inputs.netdata-nixpkgs;

  system = "x86_64-linux";
in

system-nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    {
      imports = [ nixos-hardware.nixosModules.framework-13-7040-amd ];
      # Disable fingerprint support (no need)
      services.fprintd.enable = false;
    }

    {
      nix.registry.syspkgs.flake = system-nixpkgs;
    }

    ({ config, lib, ... }: {
      imports = [ ../../modules/os-nixos/netdata-oss.nix ];
      services.netdata-oss.package = netdata-nixpkgs.legacyPackages.${system}.netdata;
      assertions = lib.mkIf config.services.netdata-oss.enable [
        {
          assertion = let
            netdataVersion = lib.getVersion config.services.netdata-oss.package;
          in lib.versionOlder netdataVersion "2.0";
          message = "Netdata must be before 2.0 to be usable locally with the web-UI, v2+ is cloud-only";
        }
      ];
    })

    ./system.nix
    ./configuration.nix
  ];
}
