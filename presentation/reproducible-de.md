# Einführung

## Wo unsere Programme herkommen

![Codeflow](img/codeflow.png)

<!--
Entwickler erzeugen git commits, signieren commits und/oder tags. Ist sicher.
Dann irgendwann erzeugen sie tarballs. Sicher falls gpg-signiert
Packagers laden die tarballs in OBS
magic happens on OBS (other distris use developer workstation)
signiertes binär-rpms und repos werden automatisch veröffentlich
Ist sicher auch bei kompromitierten mirror-Servern und http, wegen der Signaturen.

Aber wie wissen wir, dass die binaries keine Hintertüren enthalten, die beim Bauen zugefügt wurden?
-->

## Was sind reproducible builds?

* Zwei mal die Quelldateien bauen liefert die selben Ergebnisse

* * idealerweise bit-identisch (d.h. auch die selben Prüfsummen)

* * schlechter: selber Inhalt nach speziellen Filtern


## Warum reproducible builds?

* Man braucht weniger Vertauen in die build Maschinen

* Weniger last im build-service von rebuilds

* Kleinere delta-rpms in update repos

* Kann Bandbreite sparen, indem man vor Ort baut

* Man findet andere bugs im Bauvorgang (z.B. [boo#1021353](https://bugzilla.opensuse.org/show_bug.cgi?id=1021353), [boo#1021335](https://bugzilla.opensuse.org/show_bug.cgi?id=1021335))

<!--

two use-cases with overlap
dont waste build-power rebuilding dependent packages when nothing changed
make it safer

but why would a computer be non-deterministic? 2+3 should always be the same...

-->

## Typical problems

* Zeitstempel, Hostnamen

* rebuild Zähler

* Zufällige Reihenfolge beim Linken von .o Dateien

* CPU-detection beim Bauen

<!--

compile-time CPU detection libatlas3

-->

## Neue Zufalls-Quellen entdeckt #1

* gcc profile-guided optimizations
* * Wird deterministisch wenn man [immer das selbe macht](https://build.opensuse.org/request/show/499887) im Profiling-Lauf
* * or by [removing differing .gcda files](https://build.opensuse.org/request/show/498391) losing some of the optimizations, but not all

* `%ghost` files have (semi-random) sizes visible in `rpm -qp --dump`

* [ASLR](https://github.com/bmwiedemann/theunreproduciblepackage/tree/master/aslr)

## Neue Zufalls-Quellen entdeckt #2

* Unsortierte globs in python, bam, boost/jam

* * `glob.glob("*.c")` => `sorted(...)`

* * `jam` siehe https://github.com/boostorg/container/pull/50

# Der aktuelle Stand

## Work done

* 2016: 71 submit-requests
* 2017: +92 submit-requests
* 2018: +71 submit-requests

* 2016: 6 bugs filed
* 2017: +4 bugs filed: 1016848, 1017666, 1017667, 1020147
* 2018: +13 bugs filed

## Work done #2

* 2016: 4 upstream fixes merged
* 2017: +51 upstream fixes submitted - ~34 merged
* 2018: +270 upstream submissions - 162 merged


* 2017: patches for build-compare to disable filters


## rebuild-test-scripts

* Verfügbar in https://github.com/bmwiedemann/reproducibleopensuse

* Inklusive die Quellen dieser Präsentation https://github.com/bmwiedemann/reproducibleopensuse/blob/master/presentation/reproducible-de.md

## Wie reproduzierbar kann man bauen?

* bit-identisch mit Factory rpm und `osc build --define='%_buildhost reproducible' --define='%clamp_mtime_to_source_date_epoch Y' --define='%use_source_date_epoch_as_buildtime Y'`

## Wo helfen reproducible builds nicht?

* Hintertüren in den Quelldateien
* Puffer-Überläufe und andere Bugs
* Schlechte Kryptografie
* Volkswagen Test-Modus

## Wo wollen wir hin?

* Alle build-compare Probleme beheben

* Bit-identische rpms erzeugen

* Fortwährend veröffentliche Programme prüfen

* Benachrichtigen über reproducibility Regressionen in submit-requests

<!--
fully bit-identical rpms is hard - e.g. python .pyc and .elc timestamps
always hiding real build hostname would make debugging reproducibility-issues harder - would need extra metadata about it e.g. in OBS or _buildenv file

-->
