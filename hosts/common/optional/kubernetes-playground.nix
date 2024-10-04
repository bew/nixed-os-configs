{ ... }:

# https://nixos.wiki/wiki/K3s
{
  services.k3s = {
    enable = true;
    role = "server";
    # NOTE: I disable traefik for the training I'm following, as we'll deploy it ourself later
    extraFlags = ''
      --disable traefik
    '';
  };

  networking.firewall.allowedTCPPorts = [
    6443 # required so that pods can reach the API server
  ];
  # note: for some custom k3s configs other ports might be needed.
}
