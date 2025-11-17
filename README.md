# Latex 2 PDF
This repository contains the basic setup to create PDF files from Latex source. 

Copy this into a new repository:
`curl -sL https://github.com/SoenkeD/latex2pdf/archive/refs/heads/main.tar.gz | tar -xzf - --strip-components=1 -C .`

## Make it your own
- change PDF name `PDF_NAME?=root.pdf`
- add targets to `make build` e.g. to render images

## Directories
- `./.build` - contains the latex build cache and can safely be deleted with `make clean`
- `./container` - code for the `latx2pdf` container
- `./doc` - contains the Latex code to generate the PDF from