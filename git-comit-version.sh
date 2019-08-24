#!/bin/sh

# git commit founded versions and descriptions

pattern="(version[\:\s]+(\d+\.?)+|description\:)"
foundedVersions=`grep  -iP "$pattern" *.php`
echo "Founded Versions and Descriptions by 
Pattern: $pattern 

Result to commit message:
$foundedVersions

"

git add *
git add -u
git commit -m "$foundedVersions"



