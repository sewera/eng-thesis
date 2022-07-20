SRC_TEX=main.tex
SRC_BIB=bibliography.bib
SECTION_DIR=section
SECTION_FILES=$(shell find $(SECTION_DIR) -type f)

OUT_DIR=out
OUT_PDF=main.pdf

.PHONY: clean tidy

LATEXMK_OPTIONS=-output-directory=$(OUT_DIR) -bibtex -pdf -pdflatex=pdflatex

all: pdf tidy

pdf: $(OUT_DIR)/$(OUT_PDF)

$(OUT_DIR)/$(OUT_PDF): $(SRC_TEX) $(SRC_BIB) $(SECTION_FILES)
	@latexmk \
		$(LATEXMK_OPTIONS) \
		-synctex=1 \
		-f \
		-interaction=nonstopmode \
		$(SRC_TEX) > /dev/null
	@echo "> $@ rendered"

watch:
	@echo "> rendering pdf in continuous watch mode"
	@echo "> ctrl+c to stop"
	@latexmk \
		$(LATEXMK_OPTIONS) \
		-pvc \
		$(SRC_TEX) > /dev/null

rerender: clean pdf
	@echo "> clean render done"

tidy:
	@latexmk \
		$(LATEXMK_OPTIONS) \
		-c > /dev/null
	@echo "> helper files cleaned"

clean:
	@rm -rf $(OUT_DIR)
	@echo "> $(OUT_DIR) cleaned"
