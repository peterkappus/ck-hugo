#!/bin/bash

read -p "Enter book-title-with-dashes: " title

docker run --rm -it -v "$(pwd)":/src klakegg/hugo:0.50-ext new shop/$title/index.md
open content/shop/$title

echo "Drag files into folder: sample.pdf, cover.pdf, sample.m4a"

read -p "Hit enter when done"

cd content/shop/$title/

docker run -v "$(pwd)":/imgs dpokidov/imagemagick -density 500 -quality 80 -background White -layers flatten -resize 800x /imgs/cover.pdf /imgs/cover.jpg

docker run -v "$(pwd)":/imgs dpokidov/imagemagick -density 500 -quality 80 -background White -layers flatten -resize 800x /imgs/sample.pdf /imgs/sample.jpg

code content/shop/index.md