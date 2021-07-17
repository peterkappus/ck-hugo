# ck-hugo
New Hugo implementation of CarolKappus.com


## Development

### Using Docker
The last version of Hugo which supports Ace template is 0.50. To support sass compilation, we need the "extended" version of hugo so `klakegg/hugo:0.50-ext`

```
docker run --rm -it -v "$(pwd)":/src -p 1313:1313 klakegg/hugo:0.50-ext server --disableFastRender --navigateToChanged --bind=0.0.0.0 --gc --noHTTPCache
open http://localhost:1313
```

### Running hugo locally
```
hugo server --disableFastRender --navigateToChanged --bind=0.0.0.0
```


## Making new books & music to sell

* Create the new folder & index document:
* `docker run --rm -it -v "$(pwd)":/src klakegg/hugo:0.50-ext new shop/<book-title-goes-here>/index.md`
* inside the folder add the following:
** cover.pdf
** sample.m4a
** sample.pdf
* Cover & sample usually arrive as PDFs. Convert them to JPGs like so:
* Convert the sample PDF to a jpg:
  - `convert -density 500 -quality 80 -background White -layers flatten -resize 800x [name].pdf [name].jpg`
  
  
```
---
title: What Wondrous Love Is This
date: 2021-03-03T19:54:37Z
draft: false
#if this can be bought as both physical and digital
digital_price: 3
physical_price: 3
shipping: 3.50
#for digital only
display_price: 3
digital: true
sample_img_1: /shop/what-wondrous-love-is-this/sample.jpg
sample_audio_1: /shop/what-wondrous-love-is-this/sample.m4a
---
Description goes here...
```

Want to add a sample?
add `sample_audio_1: /shop/[name]/[name].m4a` to the front-matter.

## Making paypal buttons:
NOTE: It is no longer necessary to create a custom buy button for each piece. Instead we pass the name and price as parameters to a generic button.
FYI, buttons are created [here](https://www.paypal.com/bm/cgi-bin/webscr?cmd=_singleitem-intro-outside).


## Deployment
Install s3cmd
run `s3cmd sync -P public/ s3://bucketname/`
(NOTE: the -P flag makes the files public)
If you accidentally synch without this flag you can run `s3cmd setacl -Pr s3://bucketname/` to recursively make everyhting public
TROUBLESHOOTING: If you can't get s3cmd setup, try a network that doesn't need a proxy.


## Obsolete Stuff...

### Watermarking images
Use imagemagick:

`convert -size 400x200 xc:none -font Arial -pointsize 25 -kerning 1 -gravity center -fill black -annotate 330x330+0+0 "SAMPLE" -fill white -annotate 330x330+2+2  "SAMPLE" WATERMARK_FILE.png`

`composite -dissolve 20% -tile WATERMARK_FILE.png [INFILE] [OUTFILE]`
