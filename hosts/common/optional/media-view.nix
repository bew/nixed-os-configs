{ pkgs, myPkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nomacs
  ];
}
