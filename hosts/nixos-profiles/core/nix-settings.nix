let
  # Inspired from: https://jackson.dev/post/nix-reasonable-defaults/
  # (only system options, not client ones like log-lines, nix-command, flakes)
  better-nix-defaults = {
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
in {
  nix.settings = better-nix-defaults // {
    experimental-features = "nix-command flakes";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    # NOTE: Ideally I'd like to keep at least the last N known-to-work configs
    #   See related notes in 20220919T2145 to tag working config.
    options = "--delete-old --delete-older-than 30d";
  };

  # Make nix-daemon use a larger directory than /tmp for builds
  # ref: https://github.com/NixOS/nix/issues/2098
  systemd = let nix-daemon-tmp-dir = "/nix/tmp"; in {
    services.nix-daemon.environment.TMPDIR = nix-daemon-tmp-dir;
    tmpfiles.rules = [
      # https://discourse.nixos.org/t/27846/6
      # https://www.freedesktop.org/software/systemd/man/tmpfiles.d.html
      "d ${nix-daemon-tmp-dir} 0755 root root"
    ];
  };
}
