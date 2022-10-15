{
  inputs = {
    system-nixpkgs.url = github:nixos/nixpkgs/nixos-22.05;
    nixos-hardware.url = github:nixos/nixos-hardware;
  };

  outputs = inputs: {
    nixosConfigurations.frametop = import ./hosts/frametop inputs;
  };
}
