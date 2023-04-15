#!/bin/bash

# ==== edit for your situation
github_username=""
# ====

# is ansible installed?
command -v ansible > /dev/null
exit_status=$?
if [ $exit_status -gt 0 ]; then

  echo "Ansible not installed; install then try again." >&2

  # is it Mac?
  if [[ "$OSTYPE" =~ ^darwin ]]; then
    echo "To install ansible on MacOS:" >&2
    echo "" >&2
    echo "  brew update"  >&2
    echo "  brew install ansible"  >&2
    echo "" >&2
    exit 1
  fi

  # is it Ubuntu?
  if [[ $(awk -F= '/^NAME/{print $2}' /etc/os-release | sed s/\"//g)="Ubuntu" ]]; then
    echo "To install ansible on Ubuntu:" >&2
    echo "" >&2
    echo "  sudo apt update" >&2 
    echo "  sudo apt install software-properties-common" >&2 
    echo "  sudo add-apt-repository --yes --update ppa:ansible/ansible" >&2 
    echo "  sudo apt install ansible" >&2 
    echo "" >&2
    exit 1
  fi

  echo "This is not a supported OS. MacOS and Ubuntu are supported."
  exit 1
fi

# is stow installed?
command -v stow > /dev/null
exit_status=$?
if [ $exit_status -gt 0 ]; then
  ansible-pull -U https://github.com/pyqr-dev/pyqr.git -K --tags "stow"
fi

# pull 

exit 0