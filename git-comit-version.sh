#!/bin/sh

# git commit founded versions and descriptions

pattern="(version[\:\s]+(\d+\.?)+|description\:)"
pattern2="([\d]+[\.]?)+"
foundedVersions=`grep  -iP "$pattern" *.php`
version=`echo "$foundedVersions"  | grep -Po "$pattern2"`
commitdate=`ls -tl --full-time * | head -1 | awk '{print $6,$7,$8}'`

echo "Founded Versions and Descriptions by 
Pattern: $pattern 

Result to commit message:
$foundedVersions
"

git add *
git add -u
git commit -m "$foundedVersions" --date "$commitdate"


if [ ! -z "$version" ]
then
echo "Possible add tag:
"
 read -p " > git tag 'v.$version' [y/n]? " -n 1 -r
 echo    # (optional) move to a new line
 if [[ $REPLY =~ ^[Yy]$ ]]
 then
  git tag "v.$version"
 fi
fi

 read -p "git push [y/n]? " -n 1 -r
 echo    # (optional) move to a new line
 if [[ $REPLY =~ ^[Yy]$ ]]
 then
  git push --tags --set-upstream origin master
 fi
