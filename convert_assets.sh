

echo $1;

#check number of arguments....
[ "$#" -eq 1 ] || die "supply name of book as argument"

convert -density 500 -quality 80 -background White -layers flatten -resize 800x content/shop/$1/cover.pdf content/shop/$1/cover.jpg

convert -density 500 -quality 80 -background White -layers flatten -resize 800x content/shop/$1/sample.pdf content/shop/$1/sample.jpg
