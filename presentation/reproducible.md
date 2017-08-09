# Introduction

## Where does our code come from

![Codeflow](img/codeflow.png)

<!--
developers create git commits, safe because of hashes
at some point create tarballs. Safe if gpg-signed
packagers push tarballs into OBS
magic happens on OBS (other distris use developer workstation)
signed binary rpms and repos are created
safe on mirror because of signatures

but how do we know that the binaries dont contain extra backdoors added by build env
-->

## What are reproducible builds?

* Get the same results from building sources

* Two use-cases

* * ideally bit-by-bit identical (thus same hashes)

* * weaker: same content after applying some filters (via build-compare)


## Why reproducible builds?

* Need less trust in the build hosts

* Reduced load on build-service from rebuilds

* Smaller delta-rpms in update repos

* Find other bugs that corrupt data during build time (e.g. [boo#1021353](https://bugzilla.opensuse.org/show_bug.cgi?id=1021353), [boo#1021335](https://bugzilla.opensuse.org/show_bug.cgi?id=1021335))

<!--

two use-cases with overlap
dont waste build-power rebuilding dependent packages when nothing changed
make it safer

-->

## Typical problems

* embedded timestamps, hostname

* embedded rebuild counters

* random .o file link order changes optimization

* compile-time CPU detection

<!--

compile-time CPU detection libatlas3

-->

## new sources of randomness discovered

* `%if 0%{?do_profiling}` in .spec files
* * can be fixed by [always doing the same](https://build.opensuse.org/request/show/499887) in the profiling run
* * or by [removing differing .gcda files](https://build.opensuse.org/request/show/498391) losing some of the optimizations, but not all

* `%ghost` and `%dir` have (semi-random) sizes visible in rpm -qp --dump

* unsorted globs in make, python, bam, boost/jam

* * `$(wildcard *.c)` => `$(sort $(wildcard ...))`

* * `glob.glob("*.c")` => `sorted(...)`

* * jam see https://github.com/boostorg/container/pull/50

# Current state

## Work done

* 2016: 71 submit-requests
* 2017: +92 submit-requests

* 2016: 6 bugs filed
* 2017: +4 bugs filed: 1016848, 1017666, 1017667, 1020147

* 2016: 4 upstream fixes merged
* 2017: +51 upstream fixes submitted - ~34 merged

* 2017: patches for build-compare to disable filters


## rebuild-test-scripts

* available from https://github.com/bmwiedemann/reproducibleopensuse

* including this presentation's source https://github.com/bmwiedemann/reproducibleopensuse/blob/master/presentation/reproducible.md

## How reproducible can we get?

* bit-identical with factory rpm and `osc build --define='%_buildhost reproducible' --define='%clamp_mtime_to_source_date_epoch Y'`

## Where do we want to go?

* fix all build-compare issues

* produce bit-identical rpms

<!--
fully bit-identical rpms is hard - e.g. python .pyc and .elc timestamps
always hiding real build hostname would make debugging reproducibility-issues harder - would need extra metadata about it e.g. in OBS or _buildenv file

-->
