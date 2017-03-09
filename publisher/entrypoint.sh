#!/bin/bash

# Usage: entrypoint.sh git_url branch dir1 dir2 dir3 dir4 dir5 dir6
GIT_URL=$1
BRANCH=$2
DIR1=$3
DIR2=$4
DIR3=$5
DIR4=$6
DIR5=$7
DIR6=$8

ROOT_PATH="/content"
TEMP_PATH="/content/tmp"

echo "Running script to copy static content into NGinx volume"
echo "Parameters:"
echo "GIT URL: $GIT_URL"
echo "Branch: $BRANCH"
echo "Dir1: $DIR1"
echo "Dir2: $DIR2"
echo "Dir3: $DIR3"
echo "Dir4: $DIR4"
echo "Dir5: $DIR5"
echo "Dir6: $DIR6"

rm -Rf $TEMP_PATH
git clone $GIT_URL $TEMP_PATH
cd $TEMP_PATH
git checkout $BRANCH

# Delete the old content and move the new content in its place
cd $ROOT_PATH

if [ ! -z $DIR1 ]
then
  rm -Rf $DIR1; mv tmp/$DIR1 .
fi
if [ ! -z $DIR2 ]
then
  rm -Rf $DIR2; mv tmp/$DIR2 .
fi
if [ ! -z $DIR3 ]
then
  rm -Rf $DIR3; mv tmp/$DIR3 .
fi
if [ ! -z $DIR4 ]
then
  rm -Rf $DIR4; mv tmp/$DIR4 .
fi
if [ ! -z $DIR5 ]
then
  rm -Rf $DIR5; mv tmp/$DIR5 .
fi
if [ ! -z $DIR6 ]
then
  rm -Rf $DIR6; mv tmp/$DIR6 .
fi
if [ ! -z $DIR7 ]
then
  rm -Rf $DIR7; mv tmp/$DIR7 .
fi
if [ ! -z $DIR8 ]
then
  rm -Rf $DIR8; mv tmp/$DIR8 .
fi

# And clean up any remaining temp files
rm -Rf tmp

