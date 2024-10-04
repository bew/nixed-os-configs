{ system-nixpkgs, nixos-hardware, ... }:

system-nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    {
      imports = [ nixos-hardware.nixosModules.framework-12th-gen-intel ];
      # Disable fingerprint support (no need)
      services.fprintd.enable = false;
    }

    {
      nix.registry.syspkgs.flake = system-nixpkgs;
    }

    ./system.nix
    ./configuration.nix
  ];
}
