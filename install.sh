#!/bin/bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Script variables
verbose=0
save=0

while getopts "vs" opt; do
  case "$opt" in
    v)  verbose=$((verbose+1))
      ;;
    s)  save=1
      ;;
  esac
done

debug() {
  if [ $verbose -ge 1 ]; then
    echo "DEBUG =>" $*
  fi
}

error() {
  echo "ERROR =>" $*
}

#################################
## Save previous configuration ##
#################################

if [ $save -eq 1 ]; then
  debug "Save existing configuration..."
  if [ ! -d "save" ]; then
    debug "Create save folder"
    mkdir "save"
  fi
  foldername="save/"$(date -d "today" +"%Y.%m.%d.%H.%M")
  if [ ! -d $foldername ]; then
    debug "Create $foldername folder"
    mkdir $foldername
  else
    error "Save folder $foldername already exists !"
    exit -1
  fi
  vimrc=~/.vimrc
  vim=~/.vim
  debug "Copy $vim et $vimrc in $foldername"
  cp -r $vim $vimrc $foldername/
  debug "Done !"
fi

###############################
## Install vim configuration ##
###############################

debug "Install vim configuration"
echo "TODO"
