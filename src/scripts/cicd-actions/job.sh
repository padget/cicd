#!/bin/bash

function run_job() {
  echo "run job $1"
}

function job() {
  base64 encode "coucou"

  if [ $# -eq 2 ]; then

    local job_action=$1
    local job_name=$2

    case "$job_action" in

    "run") run_job "$job_name" ;;

    *) echo "unknown job action : $job_action" ;;

    esac
  fi
}
