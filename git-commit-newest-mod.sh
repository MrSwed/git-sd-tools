#!/bin/bash
# commit with date of newest file

newdate=$(for a in `git status -s | grep -oE "^M .*" | awk '{print $2}'`; do stat -c "%y" $a; done | sort -nk1r -nk2r| head -1)

GIT_AUTHOR_DATE=$newdate GIT_COMMITTER_DATE=$newdate git commit --date="$newdate"  "$@"
