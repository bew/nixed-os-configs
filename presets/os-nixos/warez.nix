{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Install with the system to ensure the same qt version is used.
    # See <20230328T1209#incompatible-qt>
    transmission_4-qt
  ];
}
