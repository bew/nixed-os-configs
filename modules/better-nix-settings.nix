{ ... }:

{
  # Some come from: https://jackson.dev/post/nix-reasonable-defaults/
  # (only system options, not client ones like log-lines, nix-command, flakes)
  nix.settings = {
    # Auto detect files in the store with identical contents, and replaces them with hard links.
    # (only possible because files in the store are immutable)
    auto-optimise-store = true;

    # Ensure the GC won't collect non-garbage outputs.
    # (like built packages or built-time dependencies)
    # NOTE: this can eat a lot of space as build-time deps of current stuff are kept around.
    keep-outputs = true;

    # Disable the global flake registry (set it to a file that doesn't exist)
    # (I don't like global state I don't control!)
    flake-registry = "/no-global-registry-please";

    # How long a downloaded tarball is considered fresh (and doesn't need to be re-fetched).
    # Default is 3600 (1h), this is short!!
    tarball-ttl = let hour = 3600; day = 24 * hour; in 7 * day;
  };
}
