_default:
  @{{just_executable()}} --list


# --- Generic actions

# Do an action for OS config of host NAME
do NAME *ARGS:
  #!/usr/bin/env bash
  host_name={{ NAME }}
  doaction_path="./hosts/${host_name}/os-scripts/doaction"
  if ! [[ -x "$doaction_path" ]]; then
    >&2 echo "!! Cannot use this action: '$doaction_path' is not executable"
    exit 1
  fi
  $doaction_path {{ NAME }} {{ ARGS }}

# Do an action for OS config of current host (host name from ./current-host-name)
re *ARGS:
  #!/usr/bin/env bash
  CURRENT_HOST_NAME_PATH=./current-host-name

  if ! [[ -f "$CURRENT_HOST_NAME_PATH" ]]; then
    >&2 echo "!! Cannot use this action: File '$CURRENT_HOST_NAME_PATH' does not exist / is not readable"
    exit 1
  fi
  host_name=$(head -n1 "$CURRENT_HOST_NAME_PATH")
  echo ":: Current host name: $host_name (found in '$CURRENT_HOST_NAME_PATH')"
  echo # blank line

  {{just_executable()}} do "$host_name" {{ ARGS }}


# --- Actions for config of given host name

# Build the given NixOS config NAME
dobuild NAME *ARGS:
  {{just_executable()}} do {{ NAME }} build {{ ARGS }}

# Switch system to the given NixOS config NAME
doswitch NAME *ARGS:
  @>&2 echo "/!\\ WARN: will need sudo to activate"
  sudo {{just_executable()}} do {{ NAME }} switch {{ ARGS }}


# --- Actions for config of current host

# Build OS config of current host (host name from ./current-host-name)
rebuild *ARGS:
  {{just_executable()}} re build {{ ARGS }}

# Switch to OS config of current host (host name from ./current-host-name)
reswitch *ARGS:
  @>&2 echo "/!\\ WARN: will need sudo to activate"
  sudo {{just_executable()}} re switch {{ ARGS }}
