{ pkgs, ... }:

# Disable the KDE file indexer `baloo` at the system level.
# Ref: https://github.com/NixOS/nixpkgs/issues/63489#issuecomment-1482312887
{
  environment = {
    etc."xdg/baloofilerc".source = (pkgs.formats.ini {}).generate "baloorc" {
      "Basic Settings" = {
        "Indexing-Enabled" = false;
      };
    };
  };
}
