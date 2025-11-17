#/bin/bash

latexmk -output-directory=/build -pdf /in/root.tex

cp /build/root.pdf /out/$1