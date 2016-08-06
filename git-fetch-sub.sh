 find . -name .git -type d -printf "\n%h\n" -execdir git fetch --all -v --progress \;
