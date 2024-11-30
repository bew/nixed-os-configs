let
  inputs = import ./inputs-npins;
  loadFlake = flakeInput: (import inputs.flake-compat { src = flakeInput; }).outputs;

  # expose inputs
  system-nixpkgs = loadFlake inputs.system-nixpkgs;
  nixos-hardware = loadFlake inputs.nixos-hardware;
in

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
