SVG := $(shell find . -name '*.svg')
SVG_PNG := $(patsubst %.svg, %.png, $(SVG))
PNG :=  $(SVG_PNG)

all: $(PNG)

%.png: %.svg
	convert -density 200 -size 400x400 -transparent white "$<" "$@"


