#!/bin/sh  

# git add -r Recursively add files by pattern
# https://gist.github.com/MrSwed/fb76fde40c6c16863c87

echo "Shorter for:  find . -name \"$1\" | xargs git add ${@:2}"
mask=*

if [[ $1 ]] 
then 
 find . -name "$1" | xargs git add ${@:2}
else 
  echo "
 Usage $0 <*.file.*.mask.*>"
fi
