_default:
  @{{just_executable()}} --list

build HOST *ARGS:
  nixos-rebuild --flake .#{{ HOST }} build {{ ARGS }}

switch HOST *ARGS:
  nixos-rebuild --flake .#{{ HOST }} switch {{ ARGS }}
