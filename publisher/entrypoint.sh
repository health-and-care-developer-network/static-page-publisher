#!/bin/bash

# Usage: entrypoint.sh git_url branch
GIT_URL=$1
BRANCH=$2

ROOT_PATH="/content"
TEMP_PATH="/content/tmp"

echo "Running script to copy static content into NGinx volume"
echo "Parameters:"
echo "GIT URL: $GIT_URL"
echo "Branch: $BRANCH"

rm -Rf $TEMP_PATH
git clone $GIT_URL $TEMP_PATH
cd $TEMP_PATH
git checkout $BRANCH

# Delete the old content and move the new content in its place
cd $ROOT_PATH
mkdir old
mv * old
mv old/tmp/* .

# And clean up the temp files
rm -Rf old

