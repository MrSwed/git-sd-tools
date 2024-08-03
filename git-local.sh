#!/bin/sh  

# git-set local reverence for braches
if [[ $1 ]]
then
 echo $1
else
  echo "Usage $0 <patch to local reference>
attach = 
    echo "/path/to/mirror" > .git/objects/info/alternates && 
    git repack -adl && 
    git repack -ad && 
    git repack -adl

detach = 
    git repack -a && 
    rm .git/objects/info/alternates
 "
fi