.PHONY: all clean

SVG := $(shell find img/ -name '*.svg')
DIA := $(shell find img/ -name '*.dia')
SVG_PNG := $(patsubst %.svg, %.png, $(SVG))
DIA_PNG := $(patsubst %.dia, %.PNG, $(DIA))
PNG :=  $(DIA_PNG) $(SVG_PNG)

%.odp: %.md	template.odp $(PNG)
	odpdown \
	-p 1 \
	--content-master No-Logo_20_Content \
	--break-master Break \
	$< template.odp $@

all: reproducible.odp

img/%.png: img/%.svg
	convert $< $@

# ugly, but will do
img/%.PNG: img/%.dia
	dia -e $@ -t svg $<

clean:
	rm -f presentation.odp
	rm -f img/*png
	rm -f img/*PNG

transcript.txt: reproducible.md
	bin/htmlcomments reproducible.md > transcript.txt

show: reproducible.odp
	ooimpress reproducible.odp &
