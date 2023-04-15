#!/bin/bash

# usage:
#  ./encrypt.sh

# returns full path of "this" directory
src_dir="$(readlink -f $(dirname "$0"))"

source "$src_dir/files-under-encryption.sh" 
files=$(files_under_encryption $src_dir)

ansible-vault encrypt ${files[@]}

printf '%s\n' ${files[@]}
exit 0