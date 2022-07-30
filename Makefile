SRC_TEX=main.tex
SRC_BIB=bibliography.bib
SECTION_DIR=section
APPENDIX_DIR=appendix
SECTION_FILES=$(shell find $(SECTION_DIR) -type f)
APPENDIX_FILES=$(shell find $(APPENDIX_DIR) -type f)

OUT_DIR=out
OUT_PDF=main.pdf

CHART_DIR=chart
SRC_DIR=src
CHART_SRC_DIR=$(CHART_DIR)/$(SRC_DIR)
CHART_OUT_DIR=$(CHART_DIR)/$(OUT_DIR)
CHART_SRC_FILES=$(shell find $(CHART_SRC_DIR) -type f -name '*.mmd')
CHART_OUT_FILES=$(CHART_SRC_FILES:$(CHART_SRC_DIR)/%.mmd=$(CHART_OUT_DIR)/%.pdf)

.PHONY: clean tidy

LATEXMK_OPTIONS=-output-directory=$(OUT_DIR) -bibtex -pdf -pdflatex=pdflatex

all: install pdf tidy

install:
	@yarn

pdf: $(OUT_DIR)/$(OUT_PDF)

$(OUT_DIR)/$(OUT_PDF): $(CHART_OUT_FILES) $(SRC_TEX) $(SRC_BIB) $(SECTION_FILES) $(APPENDIX_FILES)
	@latexmk \
		$(LATEXMK_OPTIONS) \
		-synctex=1 \
		-f \
		-interaction=nonstopmode \
		$(SRC_TEX) > /dev/null
	@echo "> $@ rendered"

chart: $(CHART_OUT_FILES)

$(CHART_OUT_DIR)/%.pdf: $(CHART_SRC_DIR)/%.mmd | $(CHART_OUT_DIR)
	@yarn mmdc --pdfFit -b transparent -i $< -o $@

$(CHART_OUT_DIR):
	@mkdir -p $(CHART_OUT_DIR)

watch: chart
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
	@rm -rf $(CHART_OUT_DIR)
	@echo "> $(CHART_OUT_DIR) cleaned"
