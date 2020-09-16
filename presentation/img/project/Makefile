SVG := $(shell find . -name '*.svg')
SVG_PNG := $(patsubst %.svg, %.png, $(SVG))
PNG :=  $(SVG_PNG)

all: $(PNG)

project.png: project.svg
	convert -density 213 -transparent white project.svg project.png
	optipng project.png

%.png: %.svg
	convert -density 200 -size 400x400 -transparent white "$<" "$@"


