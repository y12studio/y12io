#!/bin/bash
# ------------------------------------------------------------------
# enable/disable runit service script
# ------------------------------------------------------------------

set -e

SUBJECT=srvtool-id
VERSION=0.1.0
USAGE="Usage: srvtool.sh -vhyn args"

# --- Option processing --------------------------------------------
if [ $# == 0 ] ; then
    echo "$USAGE"
    exit 1;
fi

while getopts ":vhy:n:" optname; do
  case "$optname" in
    "v")
      echo "Version $VERSION"
      exit 0;
      ;;
    "y")
      SRV=$OPTARG
      TARGET=/opt/run/$SRV/run
      RDIR=/etc/service/$SRV
      if [ ! -d "$RDIR" ] && [ -f "$TARGET" ]; then
        chmod +x $TARGET
        mv /opt/run/$SRV $RDIR
        echo Enable "$SRV" 
      fi
      ls -al /etc/service
      exit 0;
      ;;
    "n")
      SRV=$OPTARG
      TARGET=/etc/service/$SRV/run
      RDIR=/opt/run/$SRV
      if [ ! -d "$RDIR" ] && [ -f "$TARGET" ]; then
        mv /etc/service/$SRV $RDIR
        echo Disable "$SRV" 
      fi
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
