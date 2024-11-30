{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # Necessary until we have a _simple_ way to make a naked shell (no stdenv env vars)
    devshell.url = "github:numtide/devshell";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, devshell, ... }:
  flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [ devshell.flakeModule ];
    systems = [ "x86_64-linux" "aarch64-darwin" ];

    # Pass OS configs attrs as raw flake outputs
    flake = import ./hosts;

    perSystem = { pkgs, ... }: {
      devshells.default = {
        packages = with pkgs; [
          just # for repo actions
          npins # to manage host' inputs
        ];

        # Override default directory name used for npins (used to manage host deps).
        env = [
          { name = "NPINS_DIRECTORY"; value = "inputs-npins"; }
        ];
      };
    };
  };
}
