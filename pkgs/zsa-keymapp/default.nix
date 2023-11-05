{
  buildFHSUserEnv,
  writeShellScript,
}:

# Copied/Adapted from: https://github.com/pope/personal/commit/5cf0d43c7ffec572b46fcd96f08c5e9748ead9d4
let

  # @2023-11 ZSA doesn't seem to have published Keymapp' sources,
  # and only give a download link to the LATEST version of the built software.
  #
  # In the meantime, download the latest version from:
  #   https://oryx.nyc3.cdn.digitaloceanspaces.com/keymapp/keymapp-latest.tar.gz
  # And put the binary locally in the repo (through Git LFS).
  keymapp-binary = ./keymapp;

in buildFHSUserEnv {
  name = "keymapp";
  runScript = writeShellScript "keymapp-wrapper.sh" ''
    exec ${keymapp-binary} "$@"
  '';
  targetPkgs = pkgs: [
    pkgs.gdk-pixbuf
    pkgs.glib
    pkgs.gtk3
    pkgs.libgudev
    pkgs.libusb1
    pkgs.systemd
    pkgs.webkitgtk
  ];
}
