all: figures/figure1.svg

%.svg: %.pdf
	pdf2svg $< $@

%.pdf: %.tex
	lualatex -halt-on-error -output-dir figures $<
