{
  inputs = {
    system-nixpkgs.url = github:nixos/nixpkgs/nixos-23.11;
    nixos-hardware.url = github:nixos/nixos-hardware;
  };

  outputs = inputs: {
    # NOTE: host names must match folder name in ./hosts for my repo actions to work for this host
    nixosConfigurations.frametop = import ./hosts/frametop inputs;
  };
}
