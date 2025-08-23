{ lib, ... }:

{
  options.me.trying-out-wayland = lib.mkOption {
    description = "Whether I'm trying out Wayland (thus need wayland variant of things)";
    type = lib.types.bool;
    default = false;
  };
}
