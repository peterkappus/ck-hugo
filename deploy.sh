#!/bin/zsh

docker run --rm -it -v "$PWD":/src -v "$PWD"/public:/target hugomods/hugo:exts hugo --logLevel debug

# create this file using secrets.sample.env and add your AWS credentials
source secrets.env

echo "Uploading to AWS"

#upload and set permissions, remove deleted files
#flags:
# --size-only (don't copy files if the size is the same in both places...faster but might miss some files (e.g. if you're only updating the year in the footer)
# --exact-timestamps (use if size is the same but you still need to update)
export FLAGS="--size-only"
#export FLAGS="--exact-timestamps"

#for debugging output
#export FLAGS="$flags --debug"

#replace garland/aws-cli-docker with the official aws docker image.
docker run --rm -it -v "$(pwd)"/public:/aws --env AWS_ACCESS_KEY_ID=$AWS_ID --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET public.ecr.aws/aws-cli/aws-cli:2.15.56 s3 sync . s3://carolkappus.com --delete $FLAGS --exclude=".git*" --acl=public-read

echo "Invalidating cache"

source secrets.env && docker run -v "$(pwd)"/public:/data --env AWS_ACCESS_KEY_ID=$AWS_ID --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET public.ecr.aws/aws-cli/aws-cli:2.15.56 cloudfront create-invalidation --distribution-id E17MFD6FKX7OIJ --paths "/*"

# FYI, multline comment syntax
: <<"long_comment"
long_comment
