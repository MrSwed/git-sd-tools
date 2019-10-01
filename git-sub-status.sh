#bash

find . -name .git -printf "\n%h\n" -execdir git status -s \;
