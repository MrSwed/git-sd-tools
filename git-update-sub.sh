 find -L ./ -name .git -printf "\n%h\n" -execdir git pull --ff-only --all -v --progress \;
