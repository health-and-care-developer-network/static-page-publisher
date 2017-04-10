#!/bin/bash

# Usage compilePages.sh registry_host target_host github_url branch dir1 dir2 dir3 dir4 dir5 dir6

REGISTRY_HOST=$1
TARGET_HOST=$2
GITHUB_URL=$3
BRANCH=$4
SOURCE_DIR=$5
TARGET_DIR_NAME=$6

VOLUME_PATH=${VOLUME_PATH:-/docker-data/static-pages}

IMAGE_NAME=nhsd/static-publish

REGISTRY_URL=$REGISTRY_HOST:5000

if [ -z $REGISTRY_HOST ]
then
  REGISTRY_HOST_PREFIX=""
  SOURCE_URL=$IMAGE_NAME
else
  REGISTRY_HOST_PREFIX="--tlsverify -H $REGISTRY_HOST:2376"
  SOURCE_URL=$REGISTRY_HOST:5000/$IMAGE_NAME
fi

if [ -z $TARGET_HOST ]
then
  TARGET_PREFIX=""
else
  TARGET_PREFIX="--tlsverify -H $TARGET_HOST:2376"
  if [ ! -z $REGISTRY_HOST ]
  then
    # Explicitly pull the latest image from the repository so we know we are using the latest
    docker $TARGET_PREFIX pull $SOURCE_URL
  fi
fi

# Generate HTML
docker $TARGET_PREFIX rm staticpublish
docker $TARGET_PREFIX run \
	--name staticpublish \
	-v $VOLUME_PATH:/content \
	--entrypoint="/entrypoint-single-dms.sh" \
	$SOURCE_URL $GITHUB_URL $BRANCH $SOURCE_DIR $TARGET_DIR_NAME
docker $TARGET_PREFIX rm staticpublish
