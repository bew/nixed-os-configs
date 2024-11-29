{ pkgs, ... }:

{
  # NOTE: Use `protonup-qt` to install a proton distribution, and go in 
  # => Make sure to enable `Steam Play` support for everything in `Settings > Compatibility` to
  #    enable Proton and allow downloading Windows games.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Install proton for Windows game compatibility
  # programs.steam.extraCompatPackages = [ pkgs.proton-ge-bin ];
  # TODO: uncomment when using 24.11 NixOS release!

  environment.systemPackages = with pkgs; [
    # UI to manage proton distributions
    # (automatically puts them in dirs that Steam can discover)
    protonup-qt

    # TUI to manage & launch Steam games
    # steam-tui
    # NOTE: uses `steamcmd`, need to login manually with this to start using TUI.
    # TODO: uncomment (and try!) when using 24.11 NixOS release!
  ];

  # TODO: setup use of `nixpkgs.config.allowUnfreePredicate` 🤔
}
