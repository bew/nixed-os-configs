{ pkgs, ... }:

{
  # When enabled, performs a reverse path filter test on a packet.
  # If a reply to the packet would not be sent via the same interface that the packet arrived on, it is refused.
  # When using asymmetric routing or other complicated routing, set this option to `loose` mode or disable it and setup your own counter-measures.
  #
  # Necessary for ProtonVPN to work
  # ref: https://discourse.nixos.org/t/how-to-configure-and-use-proton-vpn-on-nixos/65837
  networking.firewall.checkReversePath = false;

  environment.systemPackages = with pkgs; [
    protonvpn-gui
  ];
}
