#!/bin/bash
# ------------------------------------------------------------------
# ELK log utility image build script
# ------------------------------------------------------------------

set -e

SUBJECT=logelk-build-image-id
VERSION=0.1.0
USAGE="Usage: build.sh -vhoebapk:c: args"
DOCKER='sudo docker'
BASEIMG=y12elk/base
ELKIMG=y12elk/elk
REDISIMG=y12elk/redis

# --- Option processing --------------------------------------------
if [ $# == 0 ] ; then
    echo "$USAGE"
    exit 1;
fi

# TODO
function updateimg {
  $DOCKER run -t -v $TARGET:$TARGET "$OBIMG:gmaster" /opt/update.sh
  CID=$($DOCKER ps -q -l)
  $DOCKER commit "$CID" "$OBIMG:$1" > /dev/null
  $DOCKER tag "$OBIMG:$1" "$OBIMG:latest"
  echo [DOCKER] tag "$OBIMG:$1" "$OBIMG:latest"
  $DOCKER rm "$CID"
} 

while getopts ":vhber" optname; do
  case "$optname" in
    "v")
      echo "Version $VERSION"
      exit 0;
      ;;
    "e")
      echo "build the elk image"
      $DOCKER build -t "$ELKIMG" --rm=true elk
      exit 0;
      ;;
    "b")
      echo "build the base image"
      $DOCKER build -t "$BASEIMG" --rm=true base
      exit 0;
      ;;
    "r")
      echo "build the base image"
      $DOCKER build -t "$REDISIMG" --rm=true redis
      exit 0;
      ;;
    "a")
      echo "build all image"
      #$DOCKER build -t obtest/base base
      #$DOCKER build -t obtest/elk elk
      #$DOCKER build -t obtest/ob ob
      exit 0;
      ;;
    "h")
      echo "$USAGE"
      exit 0;
      ;;
    "?")
      echo "Unknown option $OPTARG"
      exit 0;
      ;;
    ":")
      echo "No argument value for option $OPTARG"
      exit 0;
      ;;
    *)
      echo "Unknown error while processing options"
      exit 0;
      ;;
  esac
done

shift "$($OPTIND - 1)"

# -----------------------------------------------------------------

LOCK_FILE=/tmp/${SUBJECT}.lock

if [ -f "$LOCK_FILE" ]; then
echo "Script is already running"
exit
fi

# -----------------------------------------------------------------
trap 'rm -f $LOCK_FILE' EXIT
touch $LOCK_FILE
