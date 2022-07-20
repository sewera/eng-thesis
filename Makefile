SRC_TEX=main.tex
SRC_BIB=bibliography.bib
SECTION_DIR=section

OUT_DIR=out
OUT_PDF=main.pdf

.PHONY: clean

all: pdf

pdf: $(OUT_DIR)/$(OUT_PDF)

$(OUT_DIR)/$(OUT_PDF): $(SRC_TEX) $(SRC_BIB) $(SECTION_DIR)/*
	@latexmk \
		-bibtex \
		-pdf \
		-output-directory=$(OUT_DIR) \
		-pdflatex=pdflatex \
		-synctex=1 \
		-f \
		-interaction=nonstopmode \
		$(SRC_TEX) > /dev/null
	@echo "> $@ rendered"

watch:
	@echo "> rendering pdf in continuous watch mode"
	@echo "> ctrl+c to stop"
	@latexmk \
		-bibtex \
		-pdf \
		-output-directory=$(OUT_DIR) \
		-pdflatex=pdflatex \
		-pvc \
		$(SRC_TEX) > /dev/null

rerender: clean pdf
	@echo "> clean render done"

clean:
	@rm -rf $(OUT_DIR)
	@echo "> $(OUT_DIR) cleaned"
