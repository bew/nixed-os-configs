# NixOS configs

## Build and switch OS config

(Assuming [just](https://github.com/casey/just) is installed/available)


To build the nixos config for host `frametop`:
```
just build frametop
```

To (build if neeeded, and) switch to the nixos config for host `frametop`:
```
sudo just switch frametop
```
