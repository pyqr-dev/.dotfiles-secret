#!/bin/bash

# ============ WARNING =========================================================
# Do not alter, rename, or delete this file - its purpose is to help ensure that  
# you do *not* commit *unencrypted* secrets to the git repository.
# ==============================================================================

# ref: https://gist.github.com/leucos/a9f42e111a8cfc2ebf6e

exit_status=0

# consider staged files with a subdirectory
files_that_must_be_encrypted=$(git diff --cached --name-only | grep -E "/")

for file in $files_that_must_be_encrypted
do
  is_encrypted=$(head -n1 $file | grep --no-messages "ANSIBLE_VAULT")
  if [ ! $is_encrypted ]; then
    echo "not encrypted: $file" >&2
    exit_status=1
  fi
done

if [ exit_status ]; then
  echo "All files in directories must be encrypted. Use ./encrypt"  >&2
  echo "COMMIT REJECTED"
fi

exit $exit_status;