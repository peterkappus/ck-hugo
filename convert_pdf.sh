[ "$#" -eq 2 ] || die "supply name of book as argument"
convert -density 500 -quality 80 -background White -layers flatten -resize 800x $1 $2

