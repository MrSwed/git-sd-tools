echo "\
for trash in \`git status -s | awk '{print \$2}'\`; do rm -r -f $trash; done;git status \
";
