#!/bin/bash
# recursive clean bare mode and filemode in all child projects git config file

for f in */.git/config
do
 if [ ! -f "$f.bak" ]
 then
    cp "$f" "$f.bak"
 fi
 sed '/^\s*bare\s*=\s*true\s*$/d' "$f.bak" | sed  '/^\s*filemode\s*=\s*true\s*$/d' > "$f";
done
