#!/bin/bash
filename=$0

if [ -n filename ]
then
    git add "${filename}"
    git commit -m "백준 ${filename} 풀이 추가"
    git push

    echo "${filename} pushed."
else
    echo "please input filename."
fi
