{ pkgs, ... }:

# Enable udev rules for keyboards from ZSA (like the Moonlander <3)
# They are needed to flash a new config, or use live training.
#
# To flash on CLI, use:
#   nix run pkgs#wally-cli my-built-firmware.bin
{
  hardware.keyboard.zsa.enable = true;
}
