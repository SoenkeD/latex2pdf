CONTAINER_RT ?= $(shell which podman || which docker)

IN_DIR?=$(PWD)/doc
BUILD_DIR?=$(PWD)/.build
OUT_DIR?=$(PWD)
PDF_NAME?=root.pdf

LATEX2PDF_NAME?=latex2pdf
LATEX2PDF_IMAGE?=latex2pdf:dev
CONTAINER_BUILDING_DIR ?= "container/"

##@ CLI
#############################
#############################
### CLI 
#############################
#############################
.PHONY: build
build: ## Build the PDF document
build: build-pdf

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[.a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Build PDF
#############################
#############################
### Build PDF 
#############################
#############################
.PHONY: build-pdf
build-pdf: create-latex-dirs ## Build the PDF from LaTeX sources
	$(CONTAINER_RT) run --rm --name $(LATEX2PDF_NAME) \
		-v $(IN_DIR):/in \
		-v $(BUILD_DIR):/build \
		-v $(OUT_DIR):/out \
		$(LATEX2PDF_IMAGE) $(PDF_NAME)

.PHONY: create-latex-dirs
create-latex-dirs: ## Create LaTeX input and build directories
	mkdir -p $(IN_DIR)
	mkdir -p $(BUILD_DIR)

##@ Helper Functions
#############################
#############################
### Helper Functions 
#############################
#############################
.PHONY: clean
clean: ## Clean the build directory
	rm -rf $(BUILD_DIR)

.PHONY: show
show: ## Open the generated PDF file
	xdg-open $(PDF_NAME)

##@ Container Building
#############################
#############################
### Latex 2 PDF container 
#############################
#############################
.PHONY: build-latex2pdf
build-latex2pdf: ## Build the latex2pdf container image
	$(CONTAINER_RT) build -t $(LATEX2PDF_IMAGE) $(CONTAINER_BUILDING_DIR)
