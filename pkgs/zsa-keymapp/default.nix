{
  buildFHSUserEnv,
  writeShellScript,
  fetchzip,
}:

# Copied/Adapted from: https://github.com/pope/personal/commit/5cf0d43c7ffec572b46fcd96f08c5e9748ead9d4
let

  # @2023-11 ZSA will not publish Keymapp' sources,
  # and only give a download link to the LATEST version of the built software.
  # NOTE: fetchzip is not limited to zip files and supports many archives formats
  keymapp-binary = fetchzip {
    url = "https://oryx.nyc3.cdn.digitaloceanspaces.com/keymapp/keymapp-latest.tar.gz";
    # WARNING: The URL is impure, it does not lock to a version, so the hash can easily be outdated
    #   (and I'd be aware of that only if I do a re-install without my current store)
    hash = "sha256-+tunfmnjFsqhkmzK3V6efcJ9u3qapx41JUzH/z4dUis";
    # archive contains binary + an icon file, don't try to extract a single file
    stripRoot = false;
  };

in buildFHSUserEnv {
  name = "keymapp";
  runScript = "${keymapp-binary}/keymapp";
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
