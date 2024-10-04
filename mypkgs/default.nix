{ pkgs }:

let
  inherit (pkgs) callPackage;
in {
  zsa-keymapp = callPackage ./zsa-keymapp {};
}
