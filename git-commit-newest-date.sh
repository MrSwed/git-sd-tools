#!/bin/bash
# commit with date of newest file

newdate=$(lc_all=en stat -c "%y" * | sort -nk1r -nk2r| head -1)

GIT_AUTHOR_DATE=$newdate GIT_COMMITTER_DATE=$newdate git commit --date="$newdate"  "$@"
