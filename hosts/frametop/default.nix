{ system-nixpkgs, nixos-hardware, ... }:

system-nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    # Known fixes for this laptop
    nixos-hardware.nixosModules.framework-12th-gen-intel
    # Adjust some things enabled by nixos-hardware's module
    (_: {
      # Disable fingerprint support (no need)
      services.fprintd.enable = false;
    })

    ({
      nix.registry.syspkgs.flake = system-nixpkgs;
    })
    # My config!
    ./configuration.nix
  ];
}
