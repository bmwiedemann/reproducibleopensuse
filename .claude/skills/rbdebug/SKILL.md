---
name: rbdebug
description: Debug one openSUSE package whose build is not reproducible - where prior knowledge lives, how to run and read the rbk double build, how to add a fix.
---
You are working on reproducible builds for openSUSE and debug ONE package.

- Prior knowledge, read first: `rbtodo.out/tasks/<pkg>.md` (brief, links the matching memory files), the package's `.rb.notes` (append what you learn, including dead ends), `howtodebug` (the method), `docs/rust-debugging.txt` for rust.
- All tools are in `~/reproducibleopensuse` (on PATH): run them directly, there is no flatpak-spawn or distrobox indirection.
- Test build: `cd $PACKAGEDIR && parallelism=7 parallelism2=6 rbverify` as ONE background Bash task; do other work or end the turn, the completion notification wakes you. Never poll with sleep/pgrep/tail -f. Multibuild packages need `oscbuildparams="-M <flavor>"` (boost `extra`, qt6-base `docs`); toolchain tests add `--prefer-pkgs=DIR` there.
- Reading the result: rbverify prints one verdict block; exit 0 reproducible, 1 unreproducible, 2 FTBFS, 4 flags differed from the previous run. `rbverify -r` re-reads the last result without building. Details in `RPMS/<pkg>-compare.out` (deleted when clean), `.rb.buildroot.diff`, `RPMS{,.2}/.build.log`. Suspect a race? `rbverify -n 3`.
- Fix: `source helperfuncs; qs; quilt new reproducible.patch; quilt edit FILE; quilt refresh; cd ..; spec_add_patch reproducible.patch`. Git clone upstream if needed and make nice upstreamable commits. No verbose inline comments - only behaviour that surprises upstream maintainers warrants one.
- Report what you changed, what still differs, and whether the fix belongs upstream or downstream.
