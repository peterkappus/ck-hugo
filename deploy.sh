#generate the files
docker run --rm -it -v "$PWD":/src -v "$PWD"/public:/target klakegg/hugo:0.50-ext

# create this file using secrets.sample.env and add your AWS credentials
source secrets.env

#upload and set permissions, remove deleted files
#flags:
# --size-only (don't copy files if the size is the same in both places...faster but might miss some files (e.g. if you're only updating the year in the footer)
# --exact-timestamps (use if size is the same but you still need to update)
docker run --rm -it -v "$(pwd)"/public:/aws --env AWS_ACCESS_KEY_ID=$AWS_ID --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET public.ecr.aws/aws-cli/aws-cli:2.15.56 s3 sync . s3://carolkappus.com --delete $FLAGS --exclude=".git*" --acl=public-read

docker run --rm -it -v "$(pwd)"/public:/aws --env AWS_ACCESS_KEY_ID=$AWS_ID --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET public.ecr.aws/aws-cli/aws-cli:2.15.56 s3 sync . s3://www.carolkappus.com --delete $FLAGS --exclude=".git*" --acl=public-read

