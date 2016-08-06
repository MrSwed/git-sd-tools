for f in *
do 
 if [ -d "${f}" ]; then
  echo ; echo $f
  cd "$f"
  if [ -d .git ]; then
   git fetch --all -v --progress
  else
   echo "no git dir. check subdirs"
   $0 
  fi
  cd ../ 
 fi
done