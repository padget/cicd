#!/bin/bash

PATH_DIR=$(dirname "$0")
PATH="$PATH_DIR:$PATH"

source "$PATH_DIR/cicd-actions/job.sh"
source "$PATH_DIR/cicd-utils/usage.sh"
source "$PATH_DIR/cicd-utils/version.sh"

case $1 in
  "job")
    shift
    job "$@" ;;
  "version" | "-version" | "--version" )
   version ;;
  "help")
    usage ;;
  *)
    echo "don't understand :( maybe read the help doc" ;;
esac


