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

if [ $save -eq 0 ]; then
  debug "Save existing configuration..."
  savefolder="/tmp/save-vim"
  if [ ! -d $savefolder ]; then
    debug "Create save folder"
    mkdir $savefolder
  fi
  saveDate=$(date +"%y-%m-%d_%H-%M")
  foldername=$savefolder/$saveDate
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

debug "Install vim configuration..."

# .vimrc
vimrc=~/.vimrc
debug "Copy vimrc as $vimrc"
cp "vimrc" $vimrc

# .vim folder
vim=~/.vim
if [ ! -d $vim ]; then
  debug "Create $vim folder"
  mkdir $vim
fi

# .vim/autoload
al=~/.vim/autoload
if [ ! -d $al ]; then
  debug "Create $al folder"
  mkdir $al
fi
debug "Copy pathogen into $al"
cp pathogen/autoload/pathogen.vim $al/

# .vim/bundle folder
bundle=~/.vim/bundle
if [ ! -d $bundle ]; then
  debug "Create $bundle folder"
  mkdir $bundle
fi
debug "Copy bundle folder content in $bundle folder"
cp -r bundle/* $bundle/

debug "Done !"
