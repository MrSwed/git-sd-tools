 find . -name .git -printf "\n%h\n" -execdir git fetch --all -v --progress \;
