# Nix-based OS configs

## Hosts

### Available hosts

- `frametop`(NixOS): My main workstation, a Framework Laptop 13.


### Hosts are managed individually

Each host has its own folder under `./hosts`.

Inputs are managed separately in each host, using [npins](https://github.com/andir/npins).
This ensures hosts can be worked-on/upgraded individually without breaking other hosts.

All host directories have a set of dedicated input-management actions:
1. `cd` into a host directory (under `./hosts`)
2. Run `just` to print available host actions


## Repo actions

Make sure [just](https://github.com/casey/just) is available in `$PATH`.
(note: use `alias j=just` for shorter/quicker/faster everything 😉)

Run `just` to print available repo actions


### Build / switch OS config for given host

To build the OS config for host `frametop`:
`just dobuild frametop`

To (build if neeeded, and) switch to the OS config for host `frametop`:
`sudo just doswitch frametop`


### Build / switch OS config for current host

Similar to previous section, but using `re` prefix instead of `do` and omitting the host name.

For example:
```sh
just rebuild # reb<TAB>
sudo just reswitch # res<TAB>
```

The name of the _current_ host is determined by reading the first line of file `./current-host-name` (which is git-ignored).
Check [`./current-host-name.example`](./current-host-name.example) for an example.
