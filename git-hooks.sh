#!/usr/bin/env bash

# Enable or disable git hooks

#find .git/hooks/ -type f ! -name "*.*"

gitHooks=.git/hooks/
echo "git Hooks $gitHooks"

option="${1}" 
case ${option} in
 "--help" | "-h" | "/?" | "-?" )
 echo "Usage:  $0 <command>
<command>
   on     - Enable hooks 
   off    - disable hooks
   --help - This help
 "
 ;;
 "on" ) echo "$1 Selected"
 find $gitHooks -type f -name "*.off" | grep "" >/dev/null  || (
 echo Nothing to $1
 exit 0
 )
 find $gitHooks -type f  -name "*.off" -exec sh -c 'mv -v "$1" "${1%.off}"' _ {} \;
 ;;
 "off" ) echo "$1 Selected"
  find $gitHooks -type f ! -name "*.*" | grep "" >/dev/null || (
  echo Nothing to $1
  exit 0
 )
 find $gitHooks -type f ! -name "*.*"  -exec sh -c 'mv -v "$1" "${1%}.off"' _ {} \; 
 ;;
 "" )
 echo "Current status:"
 find $gitHooks -type f ! -name "*.*"
 find $gitHooks -type f -name "*.off"
 ;;
esac