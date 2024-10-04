{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    file
    git
    vim # at the very least
    wget

    _7zz # 7z
    unzip
    zip
  ];
}
