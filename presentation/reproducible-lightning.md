## We want a verifiable build step

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

<!--
## RB diagram

![Codeflow](img/rbflow.png)
-->
