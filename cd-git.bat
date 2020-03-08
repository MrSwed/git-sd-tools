@echo off

if exist .git (
 if not exist .git\* (
  for /f "tokens=2" %%a in (.git) do @ cd %%a
 ) else (
  cd .git\
 )
)