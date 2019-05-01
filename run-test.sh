#!/bin/bash

cleanup() {
  kill $(jobs -p)
}

trap cleanup EXIT

push_to_log() {
  local level="error"
  while true; do
    sleep 1
    echo "{\"level\":\"$level\", \"message\":\"$(date)\"}" >> test.log
    # flip it from error to log after every iteration
    if [[ $level == "error" ]]; then
      level="log"
    else
      level="error"
    fi
  done
}

# push to log file in the background
push_to_log &

# tail it in realtime and pipe it to our JS file to filter it
tail -f test.log | ./filter-ldjson.js
