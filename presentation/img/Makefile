all: Eggs_bmw.jpg Eier_bmw.jpg
chicken.jpg: chicken.svg
	convert -density 90 -quality 25 $< $@
%.jpg: %.svg
	convert -density 120 -quality 35 $< $@
logo-text.png: logo-text.svg
	convert -density 400 $< $@
	optipng $@
