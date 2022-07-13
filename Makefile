SRC_TEX=main.tex
SRC_BIB=bibliography.bib
SECTION_DIR=section

OUT_DIR=out
OUT_PDF=main.pdf

all: pdf

pdf: $(OUT_DIR)/$(OUT_PDF)

$(OUT_DIR)/$(OUT_PDF): $(SRC_TEX) $(SRC_BIB) $(SECTION_DIR)/*
	latexmk \
		-bibtex \
		-pdf \
		-output-directory=$(OUT_DIR) \
		-pdflatex=pdflatex \
		-synctex=1 \
		-f \
		-interaction=nonstopmode \
		$(SRC_TEX)

watch:
	latexmk \
		-bibtex \
		-pdf \
		-output-directory=$(OUT_DIR) \
		-pdflatex=pdflatex \
		-pvc \
		$(SRC_TEX)
