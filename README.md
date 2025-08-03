## Building kwinsupport plugin

Dependencies:
1. libsystemd (sd-bus)
2. libwayland-shimeji-plugins.so (provided by wl_shimeji package or by wl_shimeji's `make build-plugins` (sets -Lpath that contains output libwayland-shimeji-plugins.so)
3. uthash (usually can be found in distribution's repository as `uthash` (ArchLinux), `uthash-dev` (Debian-based repositories like Ubuntu or debian itself) or `uthash-devel` (Fedora)

Building:

Separately:
```bash
  make -j$(nproc)
```

As part of wl_shimeji:
```bash
  make build-plugins
```

## Installing

Library produced by install should be installed in "{VENDOR}/wl_shimeji/" where {VENDOR} is usually /usr/lib

## Runtime dependencies

1. `XDG_CURRENT_DESKTOP` environment variable set to `KDE`
2. Access to org.kde.KWin on session bus
