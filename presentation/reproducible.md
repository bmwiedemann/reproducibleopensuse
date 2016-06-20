# Introduction

## Where does our code come from

![Codeflow](img/codeflow.png)

## What are reproducible builds?

* Get the same results from building sources

* ideally bit-by-bit identical (thus same hashes)

* * still good: same content after applying some filters (via build-compare)

<!--

-->

## Why reproducible builds?

* Need less trust in the build hosts

* Reduced load on build-service from rebuilds


## Typical problems

* embedded timestamps

* compile-time CPU detection

* embedded build counters

<!--
-->

## Current state

* 71 submit-requests

* 6 bugs filed


## rebuild-test-scripts

* available from https://github.com/bmwiedemann/reproducibleopensuse.git


