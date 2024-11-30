# Nix-based OS configs

## Available hosts

- `frametop`(NixOS): My main workstation, a Framework Laptop 13.


## Repo actions

(Assuming [just](https://github.com/casey/just) is available in `$PATH`)

### Build / switch OS config for given host

To build the OS config for host `frametop`:
```sh
just dobuild frametop
```

To (build if neeeded, and) switch to the OS config for host `frametop`:
```sh
sudo just doswitch frametop
```

### Build / switch OS config for current host

Similar to previous section, but using `re` prefix instead of `do` and omitting the host name.

For example:
```sh
just rebuild
sudo just reswitch
```

The name of the _current_ host is determined by reading the first line of file `./current-host-name`.
Check [`./current-host-name.example`](./current-host-name.example) for an example.
