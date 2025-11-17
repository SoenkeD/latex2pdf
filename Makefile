CONTAINER_RT ?= $(shell which podman || which docker)

IN_DIR?=$(PWD)/doc
BUILD_DIR?=$(PWD)/.build
OUT_DIR?=$(PWD)
PDF_NAME?=root.pdf

LATEX2PDF_NAME?=latex2pdf
LATEX2PDF_IMAGE?=latex2pdf:dev
CONTAINER_BUILDING_DIR ?= "container/"

#############################
#############################
### CLI 
#############################
#############################
.PHONY: build
build: build-pdf

#############################
#############################
### Build PDF 
#############################
#############################
.PHONY: build-pdf
build-pdf: create-latex-dirs
	$(CONTAINER_RT) run --rm --name $(LATEX2PDF_NAME) \
		-v $(IN_DIR):/in \
		-v $(BUILD_DIR):/build \
		-v $(OUT_DIR):/out \
		$(LATEX2PDF_IMAGE) $(PDF_NAME)

.PHONY: create-latex-dirs
create-latex-dirs:
	mkdir -p $(IN_DIR)
	mkdir -p $(BUILD_DIR)

#############################
#############################
### Helper Functions 
#############################
#############################
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

.PHONY: show
show:
	xdg-open $(PDF_NAME)

#############################
#############################
### Latex 2 PDF container 
#############################
#############################
.PHONY: build-latex2pdf
build-latex2pdf:
	$(CONTAINER_RT) build -t $(LATEX2PDF_IMAGE) $(CONTAINER_BUILDING_DIR)
