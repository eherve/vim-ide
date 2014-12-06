#!/bin/bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Script variables
verbose=0
save=0
skip_ftplugin=0

showHelp() {
  echo "./install [OPTIONS]"
  echo "  -h | --help       display this information"
  echo "  -v | --verbose    activate verbose mode"
  echo "  --skip-save       skip saving actual vim configuration"
  echo "  --skip-ftplugin   skip replacing the ftplugins"
}

debug() {
  if [ $verbose -ge 1 ]; then
    echo "DEBUG =>" $*
  fi
}

error() {
  echo "ERROR =>" $*
}

while test $# -gt 0; do
  case $1 in
    -v|--verbose)  verbose=$((verbose+1))
      ;;
    --skip-save)  save=1
      ;;
    --skip-ftplugin)  skip_ftplugin=1
      ;;
    -h|--help)  showHelp; exit 0
      ;;
    *) echo >&2 "Invalid argument: $1"; showHelp; exit -1
      ;;
  esac
  shift
done

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
  ctags=~/.ctags
  debug "Copy $vim, $vimrc, $ctags in $foldername"
  cp -r $vim $vimrc $ctags $foldername/

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
debug "Copy pathogen into $al folder"
cp pathogen/autoload/pathogen.vim $al/

# .vim/bundle folder
bundle=~/.vim/bundle
if [ ! -d $bundle ]; then
  debug "Create $bundle folder"
  mkdir $bundle
fi
debug "Copy bundle folder content into $bundle folder"
cp -r bundle/* $bundle/

# .vim/ftdetect
ftdetect=~/.vim/ftdetect
if [ ! -d $ftdetect ]; then
  debug "Create $ftdetect folder"
  mkdir $ftdetect
fi
debug "Copy ftdetect folder content into $ftdetect folder"
cp -r ftdetect/* $ftdetect/

# .vim/ftplugin <<<
if [ $skip_ftplugin -eq 0 ]; then
  ftplugin=~/.vim/ftplugin
  if [ ! -d $ftplugin ]; then
    debug "Create $ftplugin folder"
    mkdir $ftplugin
  fi
  debug "Copy ftplugin folder content into $ftplugin folder"
  cp -r ftplugin/* $ftplugin/
fi # >>>

# .vim/indent
indent=~/.vim/indent
if [ ! -d $indent ]; then
  debug "Create $indent folder"
  mkdir $indent
fi
debug "Copy indent folder content into $indent folder"
cp -r indent/* $indent/

# .vim/syntax
syntax=~/.vim/syntax
if [ ! -d $syntax ]; then
  debug "Create $syntax folder"
  mkdir $syntax
fi
debug "Copy syntax folder content into $syntax folder"
cp -r syntax/* $syntax/

debug "Done !"

#################################
## Install ctags configuration ##
#################################

debug "Install ctags configuration..."

ctags=~/.ctags
debug "Copy ctags as $ctags"
cp "ctags" $ctags

debug "Done !"
