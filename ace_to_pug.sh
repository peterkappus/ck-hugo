#!/bin/bash
# A very naive script to change deprecated Ace templates (https://github.com/yosssi/ace) into Pug (https://pugjs.org/api/getting-started.html) for use with Hugo (https://gohugo.io/)

# Basically a bunch of string substitutions with Perl. Not well tested. No warranty or guarnatee of any sort.

# Check if an argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

# replace extension for output file
out="${1/ace/}pug"

# Rewrite partial syntax for Pug
perl -pe "s/= include partials\/(\w+)\.html \./{{ partial \"\1\" . }}/g" $1 | \

# add a pipe in front of each pug expression {{ and preserve leading whitespace
perl -pe "s%(^\s*){%\1| {%g" | \

# single to double slash comments (preserving whitespace)
perl -pe "s%(^\s*)/%\1//%g" | \

# Add parentheses around attributes
perl -pe "s/^(\s*\S+)\s+(\S+=\".+\")/\1\(\2)/g" > $out

#rename old file to backup
git mv $1 $1.bak

# Automate this someday...
echo "Please manually change \"= include\" to \"{{ partial "partialname" . }}"
