 find -L ./ -name .git -printf "\n%h\n" -execdir git fetch --all -v --progress \; -execdir git pull --ff-only --tag --all \;
