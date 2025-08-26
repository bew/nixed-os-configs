{ pkgs, ... }:

{
  environment.systemPackages = [
    # Audio editor
    pkgs.audacity

    # Video/Audio editor
    pkgs.kdePackages.kdenlive
  ];
}
