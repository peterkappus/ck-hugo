# ck-hugo
New Hugo implementation of CarolKappus.com


### Making paypal buttons:
- Login as mom
- Go [here](https://www.paypal.com/bm/cgi-bin/webscr?cmd=_singleitem-intro-outside).
- Scroll to the bottom and click "Create 'Buy Now' Button"
- Choose button type "Buy Now"
- Enter book name, price, and shipping. Click "Create Button"
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
