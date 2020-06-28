# ck-hugo
New Hugo implementation of CarolKappus.com


## Development
```
hugo server --disableFastRender --navigateToChanged --bind=0.0.0.0
```

## converting PDFs to JPGs
`convert -density 500 -quality 80 -background White -layers flatten -resize 800x [name].pdf [name].jpg`

## Making new books & music to sell

Each book/piece should contain:
1. A cover image called "cover.jpg" (at least 800px wide and in JPG format)
2. An audio sample in "m4a" format. The name should be all lower case with dashes instead of spaces (e.g. 'the-water-is-wide.m4a')
3. A sample of the music (at least 800px and in JPG form) named the same as the audio (but with a .jpg extension)

```

* Create the new folder & index document:
* `hugo new shop/book-title-goes-here/index.md`
* Cover & sample usually arrive as PDFs. Convert them to JPGs like so:
* Convert the sample PDF to a jpg:
  - `convert -density 500 -quality 80 -background White -layers flatten -resize 800x [name].pdf [name].jpg`
* Add (and then customise) this front-matter:

```
---
title: The Parting Glass - Three Songs of Farewell
date: 2018-08-11T21:32:18-04:00
draft: false
price: 10
shipping: 3.50
digital: "false"
buy_button: (see below)
---
Description goes here...
```
Paste the `buy_button:` code into the content file (see instructions below).

Want to add a sample?
add `sample: /shop/[name]/[name].m4a` to the front-matter.

## Making paypal buttons:
- Login as mom
- Go [here](https://www.paypal.com/bm/cgi-bin/webscr?cmd=_singleitem-intro-outside).
- Scroll to the bottom and click "Create 'Buy Now' Button"
- Choose button type "Buy Now"
- Enter book name for product name
- Enter "Choose type" for Dropdown name
- For digital & print books:
  - Add options use the exact text below for the option names:
    - "Digital copy"
    - "Physical book plus shipping"
  - Add relevant prices for different options
- For digital only
  - Add price into price field (no additional options)
- Click "Create Button"
- Select "Use my secure ID"
- Copy the embed code
- Paste it into a blank document, copy only the line starting "---BEGIN PKCS7---..."
- Paste it into the "buy_button:" field in the front-matter of the book page.


## Deployment
Install s3cmd
run `s3cmd sync -P public/ s3://bucketname/`
(NOTE: the -P flag makes the files public)
If you accidentally synch without this flag you can run `s3cmd setacl -Pr s3://bucketname/` to recursively make everyhting public
TROUBLESHOOTING: If you can't get s3cmd setup, try a network that doesn't need a proxy.


### Watermarking images
Use imagemagick:

`convert -size 400x200 xc:none -font Arial -pointsize 25 -kerning 1 -gravity center -fill black -annotate 330x330+0+0 "SAMPLE" -fill white -annotate 330x330+2+2  "SAMPLE" WATERMARK_FILE.png`

`composite -dissolve 20% -tile WATERMARK_FILE.png [INFILE] [OUTFILE]`
