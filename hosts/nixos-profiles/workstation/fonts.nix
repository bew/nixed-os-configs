{ pkgs, ... }:
{
  fonts.packages = [
    pkgs.jetbrains-mono
    pkgs.fira-code
    pkgs.noto-fonts
    pkgs.google-fonts
    pkgs.twitter-color-emoji
  ];
}
