#!/bin/bash

# usage:
#  # asks for password
#  ./decrypt.sh
#
#  # password is in file (used only for testing)
#  ./decrypt.sh /path/to/password.txt

# returns full path of "this" directory
src_dir="$(realpath $(dirname "$0"))"
path_to_password_file="$1"

source "$src_dir/files-under-encryption.sh" 
files=$(files_under_encryption $src_dir)

if [ -f "$path_to_password_file" ]; then
  ansible-vault decrypt ${files[@]} --vault-password-file $path_to_password_file
else
  ansible-vault decrypt ${files[@]}
fi

exit_status=$?

if [ $exit_status -eq 0 ]; then

  printf '%s\n' ${files[@]}

  # ==== WARNING: this hook is here for your safety, do not alter! ======================
  cp "$src_dir/hook-verify-encrypted.sh" "$src_dir/.git/hooks/pre-commit"
  echo "** git pre-commit hook is in place to ensure you re-encrypt before committing **"
  # =====================================================================================
fi

exit 0