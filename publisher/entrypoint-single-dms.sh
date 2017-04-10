#!/bin/bash

# Usage: entrypoint.sh git_url branch source_dir target_dir_name
GIT_URL=$1
BRANCH=$2
SOURCE_DIR=$3
TARGET_DIR_NAME=$4

ROOT_PATH="/content"
TEMP_PATH="/content/tmp"

echo "Running script to copy static content into NGinx volume"
echo "Parameters:"
echo "GIT URL: $GIT_URL"
echo "Branch: $BRANCH"
echo "Source Dir: $SOURCE_DIR"
echo "Target Dir Name: $TARGET_DIR_NAME"

rm -Rf $TEMP_PATH
git clone $GIT_URL $TEMP_PATH
cd $TEMP_PATH
git checkout $BRANCH

# Delete the old content and move the new content in its place
cd $ROOT_PATH
mkdir specifications

if [ ! -z tmp/$SOURCE_DIR ]
then
  mkdir -p ./specifications/$TARGET_DIR_NAME
  rm -Rf ./specifications/$TARGET_DIR_NAME; mv tmp/$SOURCE_DIR ./specifications/$TARGET_DIR_NAME
fi

# And clean up any remaining temp files
rm -Rf tmp

