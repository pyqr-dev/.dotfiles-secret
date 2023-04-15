#!/bin/bash

# echoes array of filepaths

# these are paths to files that operate under encryption:
#  - ignore `$1/.git` directory
#  - ignore all files in `$1` directory
#  - note sed uses `@` as an alternate delimiter

function files_under_encryption()
{
  local files=$(find $1/*/ -type d -path ./.git -prune -o -type f -print | sed "s@//@/@")

  echo $files
  exit 0
}