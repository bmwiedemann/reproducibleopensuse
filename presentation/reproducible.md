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

<!--

two use-cases with overlap
dont waste build-power rebuilding dependent packages when nothing changed
make it safer

-->

## Typical problems

* embedded timestamps, hostname

* embedded rebuild counters

* compile-time CPU detection

<!--

compile-time CPU detection libatlas3

-->

# Current state

## Work done

* 71 submit-requests

* 6 bugs filed

* 4 upstream fixes merged

* some build-compare filters added (e.g. for javadoc)


## rebuild-test-scripts

* available from https://github.com/bmwiedemann/reproducibleopensuse

* including this presentation's source https://github.com/bmwiedemann/reproducibleopensuse/blob/master/presentation/reproducible.md

## How reproducible can we get?

* bit-identical with rpm+build from home:bmwiedemann:reproducible repo and effort

* * https://build.opensuse.org/package/rdiff/home:bmwiedemann:reproducible/build?linkrev=base&rev=2

## Where do we want to go?

* fix all build-compare issues

* not yet produce fully bit-identical rpms

<!--
fully bit-identical rpms is hard - e.g. python .pyc and .elc timestamps
always hiding real build hostname would make debugging reproducibility-issues harder - would need extra metadata about it

-->
