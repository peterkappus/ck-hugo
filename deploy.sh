hugo
s3cmd sync  -r --delete-removed -P --exclude=.git* public/ s3://stage.carolkappus.com
