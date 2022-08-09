SRC_TEX=main.tex
SRC_BIB=bibliography.bib

SECTION_DIR=section
SECTION_FILES=$(shell find $(SECTION_DIR) -type f)

APPENDIX_DIR=appendix
APPENDIX_FILES=$(shell find $(APPENDIX_DIR) -type f)

META_DIR=meta
META_FILES=$(shell find $(META_DIR) -type f)

SRC_DIR=src
OUT_DIR=out
OUT_PDF_NAME=main.pdf
OUT_PDF=$(OUT_DIR)/$(OUT_PDF_NAME)
DIST_PDF=sewera-eng-thesis.pdf

CHART_DIR=chart
CHART_SRC_DIR=$(CHART_DIR)/$(SRC_DIR)
CHART_OUT_DIR=$(CHART_DIR)/$(OUT_DIR)
CHART_SRC_FILES=$(shell find $(CHART_SRC_DIR) -type f -name '*.mmd')
CHART_OUT_FILES=$(CHART_SRC_FILES:$(CHART_SRC_DIR)/%.mmd=$(CHART_OUT_DIR)/%.pdf)

META_SRC_DIR=$(META_DIR)/$(SRC_DIR)
META_OUT_DIR=$(META_DIR)/$(OUT_DIR)

ACRONYMS_FILE=acronyms.tex
ACRONYMS_SORTED_FILE=acronyms-sorted.tex
ACRONYMS_SRC_FILE=$(META_SRC_DIR)/$(ACRONYMS_FILE)
ACRONYMS_OUT_FILE=$(META_OUT_DIR)/$(ACRONYMS_SORTED_FILE)

DEPENDENCIES_DIR=node_modules
IGNORED_FILES=indent.log *.bib.blg

.PHONY: all install install-hooks clean-hooks pdf chart sort-acronyms sort-bibliography sb dist release version rerender rmout clean nuke tidy watch open

LATEXMK_OPTIONS=-output-directory=$(OUT_DIR) -bibtex -pdf -pdflatex=pdflatex

all: install $(OUT_PDF)


# Build PDF

pdf: $(OUT_PDF)

$(OUT_PDF): $(ACRONYMS_OUT_FILE) $(CHART_OUT_FILES) $(SRC_TEX) $(SRC_BIB) $(SECTION_FILES) $(APPENDIX_FILES) $(META_FILES)
	@latexmk \
		$(LATEXMK_OPTIONS) \
		-synctex=1 \
		-f \
		-interaction=nonstopmode \
		$(SRC_TEX) > /dev/null
	@echo "> $@ rendered"


# Generate charts

chart: $(CHART_OUT_FILES)

$(CHART_OUT_DIR)/%.pdf: $(CHART_SRC_DIR)/%.mmd | $(CHART_OUT_DIR)
	@yarn mmdc --pdfFit -b transparent -i $< -o $@ > /dev/null
	@echo "> chart $@ rendered"

$(CHART_OUT_DIR):
	@mkdir -p $(CHART_OUT_DIR)
	@echo "> $(CHART_OUT_DIR) created"


# Sort acronyms

sort-acronyms: $(ACRONYMS_OUT_FILE)

$(ACRONYMS_OUT_FILE): $(ACRONYMS_SRC_FILE) | $(META_OUT_DIR)
	@sort $< > $@
	@echo "> acronyms sorted"

$(META_OUT_DIR):
	@mkdir -p $(META_OUT_DIR)
	@echo "> $(META_OUT_DIR) created"


# Sort bibliography

sb: sort-bibliography

sort-bibliography:
	@biber --tool $(SRC_BIB) --output-file=$(SRC_BIB) > /dev/null


# Project management

install: install-hooks
	@yarn
	@echo "> dependencies installed"

HOOKS_DIR=$(shell git rev-parse --show-toplevel)/.hooks
GIT_DIR=$(shell git rev-parse --absolute-git-dir)
GIT_HOOKS_DIR=$(GIT_DIR)/hooks
COMMIT_MSG_HOOK=commit-msg
PRE_COMMIT_HOOK=pre-commit

install-hooks: clean-hooks
	@ln -s $(HOOKS_DIR)/$(COMMIT_MSG_HOOK) $(GIT_HOOKS_DIR)/$(COMMIT_MSG_HOOK)
	@ln -s $(HOOKS_DIR)/$(PRE_COMMIT_HOOK) $(GIT_HOOKS_DIR)/$(PRE_COMMIT_HOOK)
	@echo "> hooks installed"

clean-hooks:
	@rm -f $(GIT_HOOKS_DIR)/*

pre-commit: sort-bibliography
	@git add -A
	@echo "> pre-commit ok"

rerender: rmout pdf
	@echo "> rerender done"

release: $(DIST_PDF) version
	@gh release create $(shell git tag | sort -r | head -n 1) $(DIST_PDF) --generate-notes

version:
	@yarn version --minor --message "chore: release"
	@git push --follow-tags

dist: $(DIST_PDF)

$(DIST_PDF): $(OUT_PDF)
	@cp $(OUT_PDF) $(DIST_PDF)
	@echo "> $(DIST_PDF) created"

rmout:
	@rm -f $(DIST_PDF)
	@echo "> rm $(DIST_PDF)"
	@rm -rf $(OUT_DIR)
	@echo "> rm $(OUT_DIR)"

clean: rmout
	@rm -rf $(CHART_OUT_DIR)
	@echo "> rm $(CHART_OUT_DIR)"
	@rm -rf $(META_OUT_DIR)
	@echo "> rm $(META_OUT_DIR)"
	@rm -f $(IGNORED_FILES)
	@echo "> rm $(IGNORED_FILES)"

nuke: clean
	@rm -rf $(DIST_PDF)
	@rm -rf $(DEPENDENCIES_DIR)
	@echo "> rm $(DEPENDENCIES_DIR)"


# Development

watch:
	@echo "> rendering pdf in continuous watch mode"
	@echo "> ctrl+c to stop"
	@while :; do \
		if ! $(MAKE) pdf > /dev/null; then \
			echo "> error when rendering pdf, see $(OUT_DIR)/main.log"; \
		fi; \
		sleep 5; \
		done


# Open

OPEN_CMD=xdg-open

ifeq (, $(shell which xdg-open))
OPEN_CMD=open
endif

open: pdf
	@$(OPEN_CMD) $(OUT_PDF)
