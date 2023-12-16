{
  inputs = {
    system-nixpkgs.url = github:nixos/nixpkgs/nixos-23.11;
    nixos-hardware.url = github:nixos/nixos-hardware;
  };

  outputs = inputs: {
    nixosConfigurations.frametop = import ./hosts/frametop inputs;
  };
}
