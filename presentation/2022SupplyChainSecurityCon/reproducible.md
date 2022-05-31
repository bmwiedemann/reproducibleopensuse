# Introduction

## Who is that guy?

* Bernhard M. Wiedemann
* working for SUSE
* involved with reproducible builds since 2016
* did over 1000 rb patches since then

## Why do reproducible builds matter?

* Users use binaries
* Hard to review binaries for backdoors
* So we review sources
* But must ensure binaries really contain what the sources say

## What are reproducible builds?

* Get the same results from building sources twice

## Typical problems

* https://github.com/bmwiedemann/theunreproduciblepackage/
* embedded timestamps, hostname
* random filesystem readdir order
* race conditions
* compile-time CPU detection

## Surprising problems

* profile guided optimization (PGO)
* security (e.g. signatures)

## Surprising benefits

* counter trusting-trust-attack with diverse double compilation (DDC)
* reduce load on build-service
* find other bugs that corrupt data during build time e.g.
    * [boo#1021353](https://bugzilla.opensuse.org/show_bug.cgi?id=1021353)
    * [boo#1021335](https://bugzilla.opensuse.org/show_bug.cgi?id=1021335)
    * https://lists.reproducible-builds.org/pipermail/rb-general/2022-March/002517.html
* For details, see https://reproducible-builds.org/docs/buy-in/

# How to debug

## Debugging

* https://github.com/bmwiedemann/reproducibleopensuse/blob/devel/howtodebug
* 0 Setup tools
* 1 Detect
* 2 Debug
* 3 Fix
* 4 Submit fix

# Questions & Answers
