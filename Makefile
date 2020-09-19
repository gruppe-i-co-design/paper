PANDOC_FLAGS= \
	--toc \
	--toc-depth 2 \
	--number-sections \
	--pdf-engine=xelatex \
	--standalone \
	--listings \
	--include-in-header header-includes.latex \
	--filter pandoc-plot \
	--filter pandoc-include-code \
	--filter pandoc-crossref \
	--filter pandoc-citeproc


PANDOC_METADATA= \
	-M classoption="oneside" \
	-M documentclass="article" \
	-M fontsize="12pt" \
	-M geometry="a4paper,margin=2.3cm" \
	-M papersize="a4paper" \
	-M secnumdepth=2 \
	-M xnos-number-sections=true \
	-M colorlinks=true \
	-M csl="bell-labs-technical-journal.csl" \
	-M listings=true \
	-M codeBlockCaptions=true \
	-M chapters=true \
	-M chaptersDepth=2


%.pdf: %.md
	pandoc $(PANDOC_METADATA) $(PANDOC_FLAGS) $^ -o $@

%.latex: %.md
	pandoc $(PANDOC_METADATA) $(PANDOC_FLAGS) $^ -o $@

default: paper.pdf

.PHONY: default
