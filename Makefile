all: figures/figure1.svg figures/figure2.svg

%.svg: %.pdf
	pdf2svg $< $@

%.pdf: %.tex
	lualatex -halt-on-error -output-dir figures $<
