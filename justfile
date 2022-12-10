_default:
  @{{just_executable()}} --list

# Build NixOS config of current system (use config with name=`hostname`)
rebuild *ARGS:
  nixos-rebuild --flake . build {{ ARGS }}

# Switch to NixOS config of current system  (use config with name=`hostname`)
reswitch *ARGS:
  echo NOTE: need sudo
  nixos-rebuild --flake . switch {{ ARGS }}

# Build the given NixOS config name
new-build NAME *ARGS:
  nixos-rebuild --flake .#{{ NAME }} build {{ ARGS }}

# Switch system to the given NixOS config name
new-switch NAME *ARGS:
  echo NOTE: need sudo
  nixos-rebuild --flake .#{{ NAME }} switch {{ ARGS }}
