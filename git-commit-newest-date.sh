#!/bin/bash
# commit with date of newest file

newdate=$(stat -c "%y" * | sort -n -k 2 | head -1)

GIT_AUTHOR_DATE=$newdate GIT_COMMITTER_DATE=$newdate git commit --date="$newdate"  "$@"
