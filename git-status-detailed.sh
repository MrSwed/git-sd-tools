#!/bin/bash

data=""
total_files=0
total_add=0
total_del=0

while IFS= read -r line; do
  status="${line:0:2}"
  file="${line:3}"

  if [ -f "$file" ]; then
    size=$(stat -c%s "$file" | numfmt --to=iec-i --suffix=B)
    date=$(stat -c%y "$file" | cut -d' ' -f1,2 | cut -d'.' -f1)

    # Проверяем, является ли файл новым (untracked или добавлен в stage)
    if [[ "$status" == "??" ]] || [[ "$status" == "A " ]] || [[ "$status" == "AM" ]]; then
      # Для новых файлов считаем все строки как добавленные
      added=$(wc -l < "$file" 2>/dev/null || echo "0")
      deleted=0
      stats="+${added}"
      total_add=$((total_add + added))
    else
      # Для модифицированных файлов используем git diff
      numstat=$(git diff --numstat HEAD -- "$file" 2>/dev/null)
      added=$(echo "$numstat" | awk '{print $1}')
      deleted=$(echo "$numstat" | awk '{print $2}')

      if [ -n "$added" ] && [ -n "$deleted" ]; then
        stats="+${added}/-${deleted}"
        total_add=$((total_add + added))
        total_del=$((total_del + deleted))
      else
        stats=""
      fi
    fi

    total_files=$((total_files + 1))
    data="${data}$(printf "%-50s %10s  %19s  %s\n" "$file" "$size" "$date" "$stats")"$'\n'
  fi
done < <(git status --porcelain)

printf "TOTAL: %d files modified | +%d/-%d lines\n" "$total_files" "$total_add" "$total_del"

echo "$data" | sort -k3 -r
