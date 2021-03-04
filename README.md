These tools are intended to make it easier
to verify that the binaries resulting from openSUSE builds are reproducible.

For this, we rebuild twice locally from source with variations in
* date
* hostname
* number of CPU cores

and compare the results
using the build-compare script that abstracts away
some unavoidable (or unimportant) differences.


Setup:
1. git clone this repo. Some parts of the code assume that it is available in ~/reproducibleopensuse

2. install dependencies with `make suseinstall`

3. `export PATH=$PATH:/path/to/reproducibleopensuse`

4. make sure you can build a package with `osc build --vm-type=kvm`
You probably need to adjust your `~/.oscrc`

This config is known to work (except for huge packages like chromium that work with 8GB RAM):

```
[general]
apiurl = https://api.opensuse.org
status_mtime_heuristic = 1
build-memory = 4096
build-vmdisk-rootsize = 40960
```

Also to build as non-root user (recommended), without having to type passwords, you need to do
`echo 'YOURUSERNAME ALL=(ALL) NOPASSWD:/usr/bin/build' > /etc/sudoers.d/oscbuild` (or `/usr/bin/obs-build` on Debian)

Usage:

You can rebuild one package using
```
osc checkout openSUSE:Factory/update-test-trivial
cd $_
rbk
```

With some packages that come with a `_multibuild` file, you need to use `multibuildrbk` instead that still has [limitations](https://github.com/openSUSE/osc/issues/376).

and you can rebuild a whole distribution using
`rebuildmany *`
in the project checkout dir.

This will create output files in `RPMS*` directories and some result files starting with `.rb` and `.build` (the dot is there to have them ignored by osc). The most interesting ones are `RPMS/*-compare.out` and `RPMS/.build.log2`

If you encounter a package that has diffs, you can use `autoclassify` to narrow down the sources of unreproducibility to a few bits. See the `rbkt` source for meaning of the bits.

You need osc >= 0.158 that understands the --build-opt param
and build >= 20171128, that understands the --vm-custom-opt param
to pass the modified base clock time to kvm.
Both are available in openSUSE Leap 42.3
and [OBS](https://build.opensuse.org/package/show/openSUSE:Tools/osc) has packages for many other Linux distributions.
